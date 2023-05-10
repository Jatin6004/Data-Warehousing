CREATE DEFINER=`admin`@`%` PROCEDURE `ETL_INCREMENT_DATA`()
BEGIN

-- Loading base table
insert into `CAR_CRASH_DATA`.`car_crashes_2022`
select * from car_crashes_dailydata;

-- 1.Loading borough
insert into dim_borough (borough_desc)                         
SELECT distinct `borough` FROM `CAR_CRASH_DATA`.`car_crashes_dailydata` where trim(borough) is not null<>'';
   
-- 2.Loading Location
insert into dim_location ( location,latitude,longitude)
SELECT distinct `location`, `latitude`,`longitude`FROM `CAR_CRASH_DATA`.`car_crashes_dailydata`;		

-- 3.Loading dim_factorvehicle
insert into dim_factorvehicle ( factor_vehicle_desc)
SELECT distinct  `factor_vehicle_1`FROM `CAR_CRASH_DATA`.`car_crashes_2022`;

-- 4.Loading Date fields
insert into dim_date (date_year,
                      date_month
                      )
SELECT year(`crash_date`), month(`crash_date`) FROM `CAR_CRASH_DATA`.`car_crashes_2022`
group by year(`crash_date`), month(`crash_date`) order by year(`crash_date`), month(`crash_date`);

-- =5. Typevehicle dimension
insert into dim_typevehicle ( typevehicle_desc)
SELECT distinct `type_vehicle_1` FROM `CAR_CRASH_DATA`.`car_crashes_2022`;

-- Delete the daily incremental data
delete from car_crashes_dailydata;

END