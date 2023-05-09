CREATE DATABASE  IF NOT EXISTS `CAR_CRASH_RPT` /*!40100 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `CAR_CRASH_RPT`;
DROP TABLE IF EXISTS `dim_borough`;
CREATE TABLE dim_borough (
  borough_id INT(11) NOT NULL AUTO_INCREMENT,
  borough_desc VARCHAR(50),
  PRIMARY KEY (borough_id)
);
DROP TABLE IF EXISTS `dim_date`;
CREATE TABLE dim_date (
  date_id INT(11) NOT NULL AUTO_INCREMENT,
  date_year INT(11),
  date_month INT(11),
  PRIMARY KEY (date_id)
);
DROP TABLE IF EXISTS `dim_location`;
CREATE TABLE dim_location (
  location_id INT(11) NOT NULL AUTO_INCREMENT,
  location VARCHAR(100),
  latitude VARCHAR(100),
  longitude VARCHAR(100),
  PRIMARY KEY (location_id)
);
DROP TABLE IF EXISTS `dim_factorvehicle`;
CREATE TABLE dim_factorvehicle (
  factorvehicle_id INT(11) NOT NULL AUTO_INCREMENT,
  factor_vehicle_desc VARCHAR(100),
  PRIMARY KEY (factorvehicle_id)
);
DROP TABLE IF EXISTS `dim_typevehicle`;
CREATE TABLE dim_typevehicle (
  typevehicle_id INT(11) NOT NULL AUTO_INCREMENT,
  typevehicle_desc VARCHAR(100),
  PRIMARY KEY (typevehicle_id)
);
DROP TABLE IF EXISTS `vehicle_crash_fact_data`;
CREATE TABLE vehicle_crash_fact_data (
  borough_id 			int(11),
  location_id 			int(11),
  factorvehicle_id		int(11),
  typevehicle_id			int(11),
  crash_violation_year 		int(11),
  crash_violation_month 	int(11),
  cnt_persons_injured	      int(11),
  cnt_persons_killed	      int(11),
  cnt_pedestraians_injured	int(11),
  cnt_pedestraians_killed     int(11),
  cnt_cyclist_injured		int(11),
  cnt_cycliest_killed	      int(11),
  cnt_motorist_injured       int(11),
  cnt_motorist_killed	     int(11),
  cnt_violations			int(11),
  FOREIGN KEY (borough_id) REFERENCES dim_borough(borough_id),
  FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
  FOREIGN KEY (factorvehicle_id) REFERENCES dim_factorvehicle(factorvehicle_id),
  FOREIGN KEY (typevehicle_id) REFERENCES dim_typevehicle(typevehicle_id)
);