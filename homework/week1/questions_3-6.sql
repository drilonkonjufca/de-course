
-- Question 3. Count records
-- How many taxi trips were there on January 15?
-- Consider only trips that started on January 15.
select
       count(*),
       min(tpep_pickup_datetime),
       max(tpep_pickup_datetime)
From yellow_taxi_trips t
where
      t.tpep_pickup_datetime >= '2021-01-15' and
      t.tpep_pickup_datetime <  '2021-01-16'
;


-- Question 4. Largest tip for each day
-- Find the largest tip for each day. On which day it was the largest tip in January?
select
    max(t.tip_amount) as largest_tip,
    date(t.tpep_pickup_datetime) as date_of_largest_tip
From yellow_taxi_trips t
where
    t.tpep_pickup_datetime >= '2021-01-01' and
    t.tpep_pickup_datetime <  '2021-02-01'
group by date(t.tpep_pickup_datetime)
order by max(t.tip_amount) desc
limit 1
;


-- Question 5. Most popular destination
-- What was the most popular destination for passengers picked up in central park on January 14?
-- Use the pick up time for your calculations.
-- Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"
select
    zdrop."Zone" as zdrop,
    zpick."Zone" as zpick,
    count(*) as number_of_pickups
From yellow_taxi_trips t
left join zone zdrop on zdrop."LocationID" = t."DOLocationID"
left join zone zpick on zpick."LocationID" = t."PULocationID"
where
    zpick."Zone" = 'Central Park' and
    t.tpep_pickup_datetime >= '2021-01-14' and
    t.tpep_pickup_datetime <  '2021-01-15'
group by t."DOLocationID", zdrop."Zone", zpick."Zone"
order by count(*) desc
limit 1
;


-- Question 6. Most expensive locations
-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?
-- Enter two zone names separated by a slash
select
    zpick."Zone" as pickup_zone,
    zdrop."Zone" as drop_zone,
    avg(t.total_amount)
From yellow_taxi_trips t
left join zone zdrop on t."DOLocationID" = zdrop."LocationID"
left join zone zpick on t."PULocationID" = zpick."LocationID"
where
    t.tpep_pickup_datetime >= '2021-01-01' and
    t.tpep_pickup_datetime <  '2021-02-01'
group by zpick."Zone", zdrop."Zone"
order by avg(t.total_amount) desc
limit 1;
