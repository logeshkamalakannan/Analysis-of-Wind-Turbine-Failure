create DATABASE project_1;
USE PROJECT_1;
SELECT * FROM DATA_SET_WT LIMIT 10;


#data cleaning
desc DATA_SET_WT;

SELECT COUNT(*) FROM DATA_SET_WT;  #3600_records

ALTER TABLE DATA_SET_WT change `date` `mod_date` date;

ALTER TABLE DATA_SET_WT
MODIFY COLUMN  mod_date date; #changing datatype text to date in date_column

alter table DATA_SET_WT change `Bearing_temperature` `Bearing_temperature` float; #rename

#NULL_CHECK
SELECT COUNT(*) - COUNT(mod_date) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Wind_speed) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Power) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Nacelle_ambient_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Generator_bearing_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Gear_oil_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Ambient_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Rotor_Speed) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Nacelle_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Bearing_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Generator_speed) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Yaw_angle) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Wind_direction) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Wheel_hub_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Gear_box_inlet_temperature) AS missing_wind_speed FROM DATA_SET_WT;
SELECT COUNT(*) - COUNT(Failure_status) AS missing_wind_speed FROM DATA_SET_WT;

#min/max check table
SELECT
    MIN(mod_date) AS min_mod_date,
    MAX(mod_date) AS max_mod_date,

    MIN(Wind_speed) AS min_Wind_speed,
    MAX(Wind_speed) AS max_Wind_speed,

    MIN(Power) AS min_Power,
    MAX(Power) AS max_Power,

    MIN(Nacelle_ambient_temperature) AS min_Nacelle_ambient_temperature,
    MAX(Nacelle_ambient_temperature) AS max_Nacelle_ambient_temperature,

    MIN(Generator_bearing_temperature) AS min_Generator_bearing_temperature,
    MAX(Generator_bearing_temperature) AS max_Generator_bearing_temperature,

    MIN(Gear_oil_temperature) AS min_Gear_oil_temperature,
    MAX(Gear_oil_temperature) AS max_Gear_oil_temperature,

    MIN(Ambient_temperature) AS min_Ambient_temperature,
    MAX(Ambient_temperature) AS max_Ambient_temperature,

    MIN(Rotor_Speed) AS min_Rotor_Speed,
    MAX(Rotor_Speed) AS max_Rotor_Speed,

    MIN(Nacelle_temperature) AS min_Nacelle_temperature,
    MAX(Nacelle_temperature) AS max_Nacelle_temperature,

    MIN(Bearing_temperature) AS min_Bearing_temperature,
    MAX(Bearing_temperature) AS max_Bearing_temperature,

    MIN(Generator_speed) AS min_Generator_speed,
    MAX(Generator_speed) AS max_Generator_speed,

    MIN(Yaw_angle) AS min_Yaw_angle,
    MAX(Yaw_angle) AS max_Yaw_angle,

    MIN(Wind_direction) AS min_Wind_direction,
    MAX(Wind_direction) AS max_Wind_direction,

    MIN(Wheel_hub_temperature) AS min_Wheel_hub_temperature,
    MAX(Wheel_hub_temperature) AS max_Wheel_hub_temperature,

    MIN(Gear_box_inlet_temperature) AS min_Gear_box_inlet_temperature,
    MAX(Gear_box_inlet_temperature) AS max_Gear_box_inlet_temperature

FROM
    DATA_SET_WT;

#1st moment decision
SELECT AVG(mod_date),AVG(Wind_speed), AVG(Power), 
AVG(Nacelle_ambient_temperature), AVG(Generator_bearing_temperature),
AVG(Gear_oil_temperature),AVG(Ambient_temperature),
AVG(Rotor_Speed),AVG(Nacelle_temperature),AVG(Bearing_temperature),
AVG(Generator_speed),AVG(Yaw_angle),AVG(Wind_direction),AVG(Wheel_hub_temperature),
AVG(Gear_box_inlet_temperature),AVG(Failure_status)FROM DATA_SET_WT;

#2nd_moment_decision(variance and standard deviation)
SELECT 
  VARIANCE(Wind_speed) AS var_wind,
  STDDEV(Wind_speed) AS std_wind,
  
  VARIANCE(Power) AS var_power,
  STDDEV(Power) AS std_power,
  
  VARIANCE(Rotor_Speed) AS var_rotor,
  STDDEV(Rotor_Speed) AS std_rotor,
  
  VARIANCE(Generator_speed) AS var_generator,
  STDDEV(Generator_speed) AS std_generator,
  
  VARIANCE(Yaw_angle) AS var_yaw,
  STDDEV(Yaw_angle) AS std_yaw,
  
  VARIANCE(Ambient_temperature) AS var_ambient,
  STDDEV(Ambient_temperature) AS std_ambient
FROM DATA_SET_WT;

#3rd moment decision (skewness)

-- Skewness for Wind_speed
SELECT 
  SUM(POWER(Wind_speed - (SELECT AVG(Wind_speed) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Wind_speed), 3)) AS skewness_wind_speed
FROM DATA_SET_WT;

-- Skewness for Power
SELECT 
  SUM(POWER(Power - (SELECT AVG(Power) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Power), 3)) AS skewness_power
FROM DATA_SET_WT;

-- Skewness for Rotor_Speed
SELECT 
  SUM(POWER(Rotor_Speed - (SELECT AVG(Rotor_Speed) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Rotor_Speed), 3)) AS skewness_rotor_speed
FROM DATA_SET_WT;

-- Skewness for Generator_speed
SELECT 
  SUM(POWER(Generator_speed - (SELECT AVG(Generator_speed) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Generator_speed), 3)) AS skewness_generator_speed
FROM DATA_SET_WT;

-- Skewness for Yaw_angle
SELECT 
  SUM(POWER(Yaw_angle - (SELECT AVG(Yaw_angle) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Yaw_angle), 3)) AS skewness_yaw_angle
FROM DATA_SET_WT;

-- Skewness for Ambient_temperature
SELECT 
  SUM(POWER(Ambient_temperature - (SELECT AVG(Ambient_temperature) FROM DATA_SET_WT), 3)) /
  (COUNT(*) * POWER(STDDEV(Ambient_temperature), 3)) AS skewness_ambient_temp
FROM DATA_SET_WT;

#4th moment decision

-- Wind_speed
SELECT 
  SUM(POWER(Wind_speed - (SELECT AVG(Wind_speed) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Wind_speed), 4)) AS kurtosis_wind_speed
FROM DATA_SET_WT;

-- Power
SELECT 
  SUM(POWER(Power - (SELECT AVG(Power) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Power), 4)) AS kurtosis_power
FROM DATA_SET_WT;

-- Rotor_Speed
SELECT 
  SUM(POWER(Rotor_Speed - (SELECT AVG(Rotor_Speed) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Rotor_Speed), 4)) AS kurtosis_rotor_speed
FROM DATA_SET_WT;

-- Generator_speed
SELECT 
  SUM(POWER(Generator_speed - (SELECT AVG(Generator_speed) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Generator_speed), 4)) AS kurtosis_generator_speed
FROM DATA_SET_WT;

-- Yaw_angle
SELECT 
  SUM(POWER(Yaw_angle - (SELECT AVG(Yaw_angle) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Yaw_angle), 4)) AS kurtosis_yaw_angle
FROM DATA_SET_WT;

-- Ambient_temperature
SELECT 
  SUM(POWER(Ambient_temperature - (SELECT AVG(Ambient_temperature) FROM DATA_SET_WT), 4)) /
  (COUNT(*) * POWER(STDDEV(Ambient_temperature), 4)) AS kurtosis_ambient_temp
FROM DATA_SET_WT;

##summary column
DROP TABLE IF EXISTS moment_summary;
CREATE TABLE moment_summary (
    Column_Name   VARCHAR(100),
    N             INT,
    MinVal        DOUBLE,
    MaxVal        DOUBLE,
    Mean          DOUBLE,
    Variance      DOUBLE,
    StdDev        DOUBLE,
    Skewness      DOUBLE,
    Kurtosis      DOUBLE
);

/* 3️⃣  Populate it – one UNION‑ALL block per column */
INSERT INTO moment_summary
SELECT 'Wind_speed', COUNT(*), MIN(Wind_speed), MAX(Wind_speed), AVG(Wind_speed), VARIANCE(Wind_speed), STDDEV(Wind_speed),
       SUM(POWER(Wind_speed - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Wind_speed), 3)),
       SUM(POWER(Wind_speed - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Wind_speed), 4))
FROM DATA_SET_WT, (SELECT AVG(Wind_speed) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Power', COUNT(*), MIN(Power), MAX(Power), AVG(Power), VARIANCE(Power), STDDEV(Power),
       SUM(POWER(Power - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Power), 3)),
       SUM(POWER(Power - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Power), 4))
FROM DATA_SET_WT, (SELECT AVG(Power) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Nacelle_ambient_temperature', COUNT(*), MIN(Nacelle_ambient_temperature), MAX(Nacelle_ambient_temperature),
       AVG(Nacelle_ambient_temperature), VARIANCE(Nacelle_ambient_temperature), STDDEV(Nacelle_ambient_temperature),
       SUM(POWER(Nacelle_ambient_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Nacelle_ambient_temperature), 3)),
       SUM(POWER(Nacelle_ambient_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Nacelle_ambient_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Nacelle_ambient_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Generator_bearing_temperature', COUNT(*), MIN(Generator_bearing_temperature), MAX(Generator_bearing_temperature),
       AVG(Generator_bearing_temperature), VARIANCE(Generator_bearing_temperature), STDDEV(Generator_bearing_temperature),
       SUM(POWER(Generator_bearing_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Generator_bearing_temperature), 3)),
       SUM(POWER(Generator_bearing_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Generator_bearing_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Generator_bearing_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Gear_oil_temperature', COUNT(*), MIN(Gear_oil_temperature), MAX(Gear_oil_temperature),
       AVG(Gear_oil_temperature), VARIANCE(Gear_oil_temperature), STDDEV(Gear_oil_temperature),
       SUM(POWER(Gear_oil_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Gear_oil_temperature), 3)),
       SUM(POWER(Gear_oil_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Gear_oil_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Gear_oil_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Ambient_temperature', COUNT(*), MIN(Ambient_temperature), MAX(Ambient_temperature),
       AVG(Ambient_temperature), VARIANCE(Ambient_temperature), STDDEV(Ambient_temperature),
       SUM(POWER(Ambient_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Ambient_temperature), 3)),
       SUM(POWER(Ambient_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Ambient_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Ambient_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Rotor_Speed', COUNT(*), MIN(Rotor_Speed), MAX(Rotor_Speed), AVG(Rotor_Speed), VARIANCE(Rotor_Speed), STDDEV(Rotor_Speed),
       SUM(POWER(Rotor_Speed - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Rotor_Speed), 3)),
       SUM(POWER(Rotor_Speed - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Rotor_Speed), 4))
FROM DATA_SET_WT, (SELECT AVG(Rotor_Speed) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Nacelle_temperature', COUNT(*), MIN(Nacelle_temperature), MAX(Nacelle_temperature),
       AVG(Nacelle_temperature), VARIANCE(Nacelle_temperature), STDDEV(Nacelle_temperature),
       SUM(POWER(Nacelle_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Nacelle_temperature), 3)),
       SUM(POWER(Nacelle_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Nacelle_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Nacelle_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Bearing_temperature', COUNT(*), MIN(Bearing_temperature), MAX(Bearing_temperature),
       AVG(Bearing_temperature), VARIANCE(Bearing_temperature), STDDEV(Bearing_temperature),
       SUM(POWER(Bearing_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Bearing_temperature), 3)),
       SUM(POWER(Bearing_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Bearing_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Bearing_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Generator_speed', COUNT(*), MIN(Generator_speed), MAX(Generator_speed),
       AVG(Generator_speed), VARIANCE(Generator_speed), STDDEV(Generator_speed),
       SUM(POWER(Generator_speed - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Generator_speed), 3)),
       SUM(POWER(Generator_speed - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Generator_speed), 4))
FROM DATA_SET_WT, (SELECT AVG(Generator_speed) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Yaw_angle', COUNT(*), MIN(Yaw_angle), MAX(Yaw_angle),
       AVG(Yaw_angle), VARIANCE(Yaw_angle), STDDEV(Yaw_angle),
       SUM(POWER(Yaw_angle - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Yaw_angle), 3)),
       SUM(POWER(Yaw_angle - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Yaw_angle), 4))
FROM DATA_SET_WT, (SELECT AVG(Yaw_angle) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Wind_direction', COUNT(*), MIN(Wind_direction), MAX(Wind_direction),
       AVG(Wind_direction), VARIANCE(Wind_direction), STDDEV(Wind_direction),
       SUM(POWER(Wind_direction - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Wind_direction), 3)),
       SUM(POWER(Wind_direction - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Wind_direction), 4))
FROM DATA_SET_WT, (SELECT AVG(Wind_direction) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Wheel_hub_temperature', COUNT(*), MIN(Wheel_hub_temperature), MAX(Wheel_hub_temperature),
       AVG(Wheel_hub_temperature), VARIANCE(Wheel_hub_temperature), STDDEV(Wheel_hub_temperature),
       SUM(POWER(Wheel_hub_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Wheel_hub_temperature), 3)),
       SUM(POWER(Wheel_hub_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Wheel_hub_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Wheel_hub_temperature) AS avg_val FROM DATA_SET_WT) a

UNION ALL
SELECT 'Gear_box_inlet_temperature', COUNT(*), MIN(Gear_box_inlet_temperature), MAX(Gear_box_inlet_temperature),
       AVG(Gear_box_inlet_temperature), VARIANCE(Gear_box_inlet_temperature), STDDEV(Gear_box_inlet_temperature),
       SUM(POWER(Gear_box_inlet_temperature - a.avg_val, 3)) / (COUNT(*) * POWER(STDDEV(Gear_box_inlet_temperature), 3)),
       SUM(POWER(Gear_box_inlet_temperature - a.avg_val, 4)) / (COUNT(*) * POWER(STDDEV(Gear_box_inlet_temperature), 4))
FROM DATA_SET_WT, (SELECT AVG(Gear_box_inlet_temperature) AS avg_val FROM DATA_SET_WT) a;

/* 4️⃣  Review the summary */
SELECT * FROM moment_summary;