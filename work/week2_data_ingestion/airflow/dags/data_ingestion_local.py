from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime
import os
from sqlalchemy import create_engine
from ingest_script import ingest_callable

AIRFLOW_HOME=os.environ.get("AIRFLOW_HOME","/opt/airflow/")

PG_HOST = os.getenv('PG_HOST')
PG_USER = os.getenv('PG_USER')
PG_PASSWORD = os.getenv('PG_PASSWORD')
PG_PORT = os.getenv('PG_PORT')
PG_DATABASE = os.getenv('PG_DATABASE')



default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 0,
}


local_workflow = DAG(
    "local_ingestion_dag",
    schedule_interval="0 6 2 * *",
    start_date=datetime(2021,1,1),
    end_date=datetime(2021,6,1),
    default_args=default_args
)


URL = 'https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_{{logical_date.strftime("%Y-%m")}}.csv'
OUTPUTFILE = AIRFLOW_HOME+'/output_{{logical_date.strftime("%Y-%m")}}.csv'
TABLE = 'yellow_taxi_trips_{{logical_date.strftime("%Y-%m")}}'

with local_workflow:

    wget_task = BashOperator(
        task_id = "wget",
        # bash_command=f'ls'
        bash_command=f'curl -sSL {URL} > {OUTPUTFILE}'
    )

    ingest_task = PythonOperator(
        task_id="ingest",
        python_callable=ingest_callable,
        op_kwargs=dict(
            user=PG_USER,
            password=PG_PASSWORD,
            host=PG_HOST, 
            port=PG_PORT, 
            db=PG_DATABASE, 
            table_name=TABLE, 
            csv_file=OUTPUTFILE
        )
    )


    wget_task >> ingest_task