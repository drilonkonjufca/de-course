import pandas as pd
from sqlalchemy import create_engine, desc
from time import time
import argparse
import os


def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url

    csv_name = "output.csv"

    os.system(f"wget {url} -O {csv_name}")


    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")


    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)


    df: pd.DataFrame = next(df_iter)
    df.tpep_pickup_datetime  = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    #create table
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists="replace")

    #import data
    while True:
        t_start = time()
        df = next(df_iter)
        df.to_sql(name=table_name, con=engine, if_exists="append")
        t_end = time()
        print("inserted another chunk..., took %.3f second" % (t_end-t_start))



if __name__=="__main__":
    parser = argparse.ArgumentParser(description="Ingest CSV data to Postgres")

    parser.add_argument("--user", help="user name for postgres")
    parser.add_argument("--password", help="passowrd for postgres")
    parser.add_argument("--host", help="host for postgres")
    parser.add_argument("--port", help="port for postgres")
    parser.add_argument("--db", help="database for postgres")
    parser.add_argument("--table_name", help="name of table where we will write the results to")
    parser.add_argument("--url", help="url of csv file")
    args = parser.parse_args()

    main(args)