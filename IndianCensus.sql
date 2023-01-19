show databases;
select * from dataset1.data1;

-- No. of rows in the dataset
select count(*) from dataset1.data1;

-- Data of karnataka and Delhi
select * from dataset1.data1 where state in ('Karnataka','Delhi');

-- Population of India
select sum(population) as total_population from dataset2.data2;

-- Average growth rate
select avg(growth) from dataset1.data1;

-- Average growth by State
select state, avg(growth) from dataset1.data1 group by state;

-- Average sex ratio by state
select state, avg(sex_ratio) as avg_sex_ratio from dataset1.data1 group by state order by avg_sex_ratio desc;

-- 5 states with highest average literacy rate
select state, avg(Literacy) as avg_literacy_rate from dataset1.data1 group by state order by avg_literacy_rate desc limit 5;

-- 5 States with lowest sex ratio
select state, avg(sex_ratio) as avg_sex_ratio from dataset1.data1 group by state order by avg_sex_ratio asc limit 5;

-- 3 States with highest and lowest literacy rate
select * from (select state, avg(Literacy) as avg_literacy_rate from dataset1.data1 group by state order by avg_literacy_rate desc limit 3) as a
UNION
select * from (select state, avg(Literacy) as avg_literacy_rate from dataset1.data1 group by state order by avg_literacy_rate asc limit 3) as b;

-- All states starting with letter K
select distinct state from dataset1.data1 where state like 'k%';

-- All states starting with letter A or M
select distinct state from dataset1.data1 where state like 'a%' or state like 'm%' order by state asc;

-- All  states ending with letter A
select distinct state from dataset1.data1 where state like '%a' order by state asc;

-- Joining both the tables of data1 and data2
select a.district, a.state, a.sex_ratio, b.population from dataset1.data1 as a inner join dataset2.data2 as b on a.district=b.District
order by state asc;

-- Get the no. of males and females from the population and sex ratio
select c.district, c.state, c.population, c.sex_ratio, round((c.population/(c.sex_ratio+1))*1000,0) as males, 
round((c.population)-((c.population)/(c.sex_ratio+1)),0) 
as females from (select a.district, a.state, a.sex_ratio, b.population from dataset1.data1 as a inner join dataset2.data2 as b 
on a.district=b.District order by state asc) as c;

-- Get the total no. of literate and illiterate people from the population and literacy
select c.state, c.literacy, c.population, round(((c.literacy*c.population)/100),0) as literate_people,
round((c.population - ((c.literacy*c.population)/100)),0) as illiterate_people from
(select a.state, a.literacy, b.population from dataset1.data1 as a inner join dataset2.data2 as b on a.district=b.district) as c
group by c.state order by literacy desc;

-- Get the previous year census population based on growth
select a.district, a.state, a.growth, b.population from dataset1.data1 as a inner join dataset2.data2 as b on a.district=b.district;

select c.state, c.growth, c.population as current_population, round((c.population*(1-(c.growth/100))),0) as previous_population from
(select a.district, a.state, a.growth, b.population from dataset1.data1 as a inner join dataset2.data2 as b on a.district = b.district) 
as c group by c.state order by c.growth asc;

-- Population density using population and area
select state, area_km2, population, population/area_km2 as population_density from dataset2.data2 group by state order by population_density asc; 















