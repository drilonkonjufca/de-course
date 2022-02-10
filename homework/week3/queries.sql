
-- Question 1:
-- What is count for fhv vehicles data for year 2019
select count(*) from trips_data_all.fhv
;



-- Question 2:
-- How many distinct dispatching_base_num we have in fhv for 2019
select 
    count(distinct dispatching_base_num) 
from trips_data_all.fhv
;



-- Question 3: 
-- Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num
-- Answer: Partition by dropoff_datetime and clustered by dispatching_base_num



-- Question 4:

-- What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279
-- Create a table with optimized clustering and partitioning, and run a count(*). Estimated data processed can be found in top right corner and actual data processed can be found after the query is executed.

-- Creating partition and clustered table based on raw parquet files on external table
CREATE OR REPLACE TABLE trips_data_all.fhv_partitoned
PARTITION BY DATE(pickup_datetime) 
CLUSTER BY dispatching_base_num AS
SELECT * FROM trips_data_all.fhv;

-- query to run for estimation and processed cost 
select
    count(*)
from trips_data_all.fhv
where
    date(pickup_datetime) between '2019-01-01' and '2019-03-31' and
    dispatching_base_num in ('B00987','B02060','B02279')
;



-- Question 5:

-- What will be the best partitioning or clustering strategy when filtering on dispatching_base_num and SR_Flag
-- Review partitioning and clustering video. Clustering cannot be created on all data types.

-- Answer: Partition by dispatching_base_num and cluster by SR_Flag



-- Question 6:

-- What improvements can be seen by partitioning and clustering for data size less than 1 GB
-- Partitioning and clustering also creates extra metadata.

-- Answer: probably no gains



-- Question 7:

-- In which format does BigQuery save data
-- Review big query internals video.

-- Answer: Columnar format


