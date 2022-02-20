


--630,918
SELECT count(*) FROM `tribal-bird-339019.trips_data_all.green_tripdata`


--7,778,101
SELECT count(*) FROM `tribal-bird-339019.trips_data_all.green_tripdata_raw`


create table `tribal-bird-339019.trips_data_all.green_tripdata` as
SELECT vendorid,lpep_pickup_datetime,lpep_dropoff_datetime,store_and_fwd_flag,ratecodeid,pulocationid,dolocationid,passenger_count,trip_distance,fare_amount,extra,mta_tax,tip_amount,tolls_amount,improvement_surcharge,total_amount,payment_type,trip_type,congestion_surcharge FROM `tribal-bird-339019.trips_data_all.green_tripdata_raw`
;


--7,778,101
select count(*) from `tribal-bird-339019.trips_data_all.green_tripdata`;


--6,304,783
select count(*) from `tribal-bird-339019.production.stg_green_tripdata`;


--56,100,630
select count(*) from `tribal-bird-339019.production.stg_yellow_tripdata`;


--109,047,518
select count(*) from `tribal-bird-339019.trips_data_all.yellow_tripdata`;


select min(f.pickup_datetime), max(f.pickup_datetime) from `tribal-bird-339019.production.fact_trips` f
;



select count(*) from `tribal-bird-339019.production.fact_trips` f
where f.pickup_datetime > '2019-01-01' and f.pickup_datetime< '2021-01-01'
;



--36,091,586
select count(*) from `tribal-bird-339019.production.stg_fhv_tripdata`;


--42,084,899
select count(*) from `tribal-bird-339019.trips_data_all.fhv_tripdata`;

--36091586
select count(*) from (
select distinct dispatching_base_num, pickup_datetime from `tribal-bird-339019.trips_data_all.fhv_tripdata`
)



--22676253
with zones as (
 select * from `tribal-bird-339019.production.dim_zones`
    where borough != 'Unknown'
)
select 
    count(*)
from `tribal-bird-339019.trips_data_all.fhv_tripdata` t
inner join zones z on z.locationid = t.PULocationID
inner join zones z2 on z2.locationid = t.DOLocationID
;



--115,262,890
with tripdata as (
    select t.VendorID, t.tpep_pickup_datetime, t.tpep_dropoff_datetime, t.PULocationID, t.DOLocationID from `tribal-bird-339019.trips_data_all.yellow_tripdata` t
    UNION ALL
    select r.vendorid, r.lpep_pickup_datetime, r.lpep_dropoff_datetime, r.pulocationid, r.dolocationid from `tribal-bird-339019.trips_data_all.green_tripdata` r
)
,zones as (
 select * from `tribal-bird-339019.production.dim_zones`
    where borough != 'Unknown'
)
select 
    count(*) 
from tripdata t
inner join zones z on z.locationid = t.PULocationID
inner join zones z2 on z2.locationid = t.DOLocationID
;




with zones as (
 select * from `tribal-bird-339019.production.dim_zones`
    where borough != 'Unknown'
)
select 
    date_trunc(t.pickup_datetime, month) as month,
    count(*)
from `tribal-bird-339019.trips_data_all.fhv_tripdata` t
inner join zones z on z.locationid = t.PULocationID
inner join zones z2 on z2.locationid = t.DOLocationID
group by month
order by 
1

;


select * from `tribal-bird-339019.trips_data_all.fhv_tripdata` f
where f.pickup_datetime between '2019-01-01' and '2019-01-31'
;


select 
date_trunc(t.pickup_datetime, month) as month,
    count(*)
from `tribal-bird-339019.production.fact_fhv_trips` t
group by month
order by 
1
;





