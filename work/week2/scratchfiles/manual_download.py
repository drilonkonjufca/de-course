import pyarrow as pa
import pyarrow.csv as pv
import pyarrow.parquet as pq
import pandas as pd

table = pv.read_csv("fhv_tripdata_2020-01.csv")

table.Schema


df = pd.read_csv("work/week2/manualscripts/fhv_tripdata_2020-01.csv2")
df.pickup_datetime  = pd.to_datetime(df.pickup_datetime)
df.dropoff_datetime = pd.to_datetime(df.dropoff_datetime)

# table2 = pd.read_csv("work/week2/manualscripts/fhv_tripdata_2020-01.csv", engine="pyarrow")
# df = pd.read_csv("work/week2/manualscripts/fhv_tripdata_2020-01.csv")
 
table = pa.Table.from_pandas(df)


pq.write_table(table, "work/week2/manualscripts/fhv_tripdata_2020-01.parquet")



# # curl -sSLf https://s3.amazonaws.com/nyc-tlc/trip+data/fhv_tripdata_2020-01.csv > fhv_tripdata_2020-01.csv

#wget https://s3.amazonaws.com/nyc-tlc/trip+data/fhv_tripdata_2020-01.csv -o fhv_tripdata_2020-01.csv2