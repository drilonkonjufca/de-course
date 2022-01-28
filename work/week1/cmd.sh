
#build and run pipeline
docker build -t de .
docker run -it de

# run a postgres DB
docker run -it \
    --name de_postgres \
    --network=pg_network \
    -v pg_data:/var/lib/postgresql/data/ \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -e POSTGRES_DB=$POSTGRES_DB \
    -p 5432:5432 \
postgres:13


# connect through cli
pgcli -h localhost -u root -d ny_taxi -p 5432

# set environment variables
URL="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv"
source .env

# run ingestion script from python directly
python3 ingest_data.py \
    --user=root \
    --password=$POSTGRES_PASSWORD \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=$URL

# run pipeline through docker
docker run -it --network=pg_network de \
    --user=root \
    --password=$POSTGRES_PASSWORD \
    --host=de_postgres \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=$URL


# starting postgres from compose
docker-compose up -d     

# initiating gcloud
export GOOGLE_APPLICATION_CREDENTIALS=~/.ssh/gcloud/de_course/tribal-bird-339019-922b2fc81066.json
gcloud init
gcloud auth -default login

gcloud --version

# applying teffarom for creating resources
terraform init
terraform plan
terraform apply