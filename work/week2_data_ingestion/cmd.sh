

#Ensure that google credentials in home folder
file ~/.google/credentials/google_credentials.json

#create airflow folder
mkdir airflow
cd airflow

#create subfolders
mkdir -p ./dags ./logs ./plugins

#get docker-compose
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'

#add user to env file
echo -e "AIRFLOW_UID=$(id -u)" > .env


#build from docker compose
docker-compose build

#run initialization
docker-compose up airflow-init

#run airflow
docker-compose up -d


#install libraries
pip install apache-airflow


docker-compose -f ~/code/de-course/work/week1/docker-compose.yml down
docker-compose -f ~/code/de-course/work/week1/docker-compose.yml up -d


#restart airflow and postgres
docker-compose -f ~/code/de-course/work/week1/docker-compose.yml down
docker-compose down -v

docker-compose up airflow-init
docker-compose up -d
docker-compose -f ~/code/de-course/work/week1/docker-compose.yml up -d
