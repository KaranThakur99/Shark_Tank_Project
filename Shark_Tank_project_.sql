select *  from project_1..data


-- total episodes

select distinct epno  from project_1..data

select count(distinct epno)  from project_1..data
select max(epno)  from project_1..data

-- pitches
select count(distinct brand)  from project_1..data

--pitches converted

select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from project_1..data
select sum(converted_not_converted), count(*)  from project_1..data

-- total male

 select sum(male) from project_1..data

 -- total female

 select sum(female) from project_1..data
 --gender ratio

 select sum(female)/sum(male) from project_1..data

 --total amount invested

 select sum(amountinvestedlakhs) from project_1..data

 -- avg equity taken
 select avg(equitytakenp)  from project_1..data where equitytakenp>0

 --highest deal taken

 select max(amountinvestedlakhs) from project_1..data
  
  --hihest equity taken 
  select max(equitytakenp) from project_1..data

  --atleast one women
  select sum(a.female_count) from
 (select female, case when female>0 then 1 else 0 end as female_count from project_1..data)a    -- a is used to give alias or can write as a, both is correct

 -- pitches converted having atleast one women
 select * from project_1..data
 select sum(b.female_count) from(
 select a.* ,case when a.female>0 then 1 else 0 end as female_count from (
 (select *  from project_1..data where deal != 'No Deal')) as a) as b

 --avg of team members
 select avg(teammembers) from project_1..data

 --avg amount invested per deal who converted not for all
 select avg(a.amountinvestedlakhs) from (
 select deal, amountinvestedlakhs from project_1..data where deal != 'no deal')a   -- a is alias

 --avg age group of contestents
 select avg_age,count(avg_age)as cnt from project_1..data group by(avg_age) order by cnt desc

 --location of contestants
 select locationn, count(locationn) as loc from project_1..data  group by locationn order by loc desc


 --sector of contestants
 select sector, count(sector) as sec from project_1..data  group by sector order by sec desc

 --partner deals
 select partners, count(partners) as cnt from project_1..data where partners!= '-' group by partners order by cnt desc

 -- making the matrix

 select count(ashneeramountinvested) from project_1..data where ashneeramountinvested is not null


 select count(ashneeramountinvested) from project_1..data where ashneeramountinvested is not null and ashneeramountinvested != 0

 select  sum(c.ashneeramountinvested), avg(c.AshneerEquityTakenp)
 from(select * from project_1..data where AshneerEquityTakenp!=0 and AshneerEquityTakenp is not null) as c

 --hiiiii
 select 'ashneer' as keyy,  count(ashneeramountinvested) from project_1..data where ashneeramountinvested is not null


 select 'ashneer' as keyy, count(ashneeramountinvested) from project_1..data where ashneeramountinvested is not null and ashneeramountinvested != 0

 select 'ashneer'as keyy, sum(c.ashneeramountinvested), avg(c.AshneerEquityTakenp)
 from(select * from project_1..data where AshneerEquityTakenp!=0 and AshneerEquityTakenp is not null) as c


 -- inner join.......................

 select a.keyy, a.total_deals_present, b.total_deals_converted from(

 select 'ashneer' as keyy, count(ashneeramountinvested) as total_deals_present  from project_1..data
 where ashneeramountinvested is not null) a

 inner join (


 select 'ashneer' as keyy, count(ashneeramountinvested) as total_deals_converted from project_1..data
 where ashneeramountinvested is not null and ashneeramountinvested != 0) b
 
 on a.keyy = b.keyy


 --joining all of them now
 select m.keyy, m.total_deals_present, m.total_deals_converted, n.total_amount_invested, n.avg_equity_taken from
 (select a.keyy, a.total_deals_present, b.total_deals_converted from(

 select 'ashneer' as keyy, count(ashneeramountinvested) as total_deals_present  from project_1..data
 where ashneeramountinvested is not null) a

 inner join (


 select 'ashneer' as keyy, count(ashneeramountinvested) as total_deals_converted from project_1..data
 where ashneeramountinvested is not null and ashneeramountinvested != 0) b
 on a.keyy = b.keyy) as m

 inner join

(select 'ashneer'as keyy, sum(c.ashneeramountinvested) as total_amount_invested,
 avg(c.AshneerEquityTakenp) as avg_equity_taken 
 from(select * from project_1..data where AshneerEquityTakenp!=0 and AshneerEquityTakenp is not null) as c) as n

 on m.keyy = n.keyy

 -- which is the startup in which highest amount has benn invested in each sector.
 --window function
 --in rank fuction it will give rank to the startups according to the money invested in each sector.
 --dense rank and row number fuction try to do

 select brand,sector, amountinvestedlakhs, rank() over(partition by sector order by  amountinvestedlakhs desc) as rnk
 from project_1..data

 ---for rnk 1 only
 select c.* from
(select brand,sector, amountinvestedlakhs, rank() over(partition by sector order by  amountinvestedlakhs desc) as rnk
 from project_1..data) as c

 where c.rnk = 1










