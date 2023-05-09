use CAR_CRASH_RPT ;
-- 1.Loading dim_borough dimension
insert into dim_borough (borough_desc)                         
SELECT distinct `borough` FROM `CAR_CRASH_DATA`.`car_crashes_2022` where trim(borough) is not null<>'';
   
-- 2.Loading Location
insert into dim_location ( location,latitude,longitude)
SELECT distinct `location`, `latitude`,`longitude`FROM `CAR_CRASH_DATA`.`car_crashes_2022`;		

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

-- 5.Loading fact orders
Insert into vehicle_crash_fact_data (
		borough_id,
		location_id,
		factorvehicle_id,
		typevehicle_id,
		crash_violation_year,
		crash_violation_month,
		cnt_persons_injured,
		cnt_persons_killed,
		cnt_pedestraians_injured,
		cnt_pedestraians_killed,
		cnt_cyclist_injured,
		cnt_cycliest_killed,
        cnt_motorist_injured,
        cnt_motorist_killed,
		cnt_violations)
select 
		db.borough_id,
        dl.location_id,
        df.factorvehicle_id,
        dt.typevehicle_id,
        year(`crash_date`) crash_violation_year,
        month(`crash_date`) crash_violation_month,
        `number_person_injured` cnt_persons_injured,
        `number_person_killed` cnt_persons_killed,
        `number_pedestrian_injured` cnt_pedestraians_injured,
        `number_pedestrian_killed` cnt_pedestraians_killed,
        `number_cyclist_injured` cnt_cyclist_injured,
        `number_cyclist_killed` cnt_cycliest_killed,
        `number_motorist_injured` cnt_motorist_injured,
        `number_motorist_killed` cnt_motorist_killed,
        ( 
		select `no_of_violations`
		from  `CAR_CRASH_DATA`.`traffic_violations_data` b
		where a.BOROUGH = b.court
		and month(a.crash_date) = b.violation_month
		and year(a.crash_date) = b.violation_year) cnt_violations 
	    from
			`CAR_CRASH_DATA`.`car_crashes_2022` a ,
            dim_borough db,
            dim_location dl,
            dim_factorvehicle df,
            dim_typevehicle dt
		where
		 a.`borough` = db.borough_desc
        and a.`location` = dl.location
        and a.`latitude` = dl.latitude
        and a.`longitude` = dl.longitude
		and a.`factor_vehicle_1` = df.factor_vehicle_desc
        and a.`type_vehicle_1` = dt.typevehicle_desc 
      					
