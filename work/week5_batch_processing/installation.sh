#install java
sudo apt install openjdk-11-jdk-headless

#config if more java version are installed
sudo update-alternatives --config java

#env
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

#donwload spark
wget https://dlcdn.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop3.2.tgz

#extract
tar xzfv spark-3.0.3-bin-hadoop3.2.tgz

#set environment variables
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export SPARK_HOME="${HOME}/spark/spark-3.0.3-bin-hadoop3.2"
export PATH="${SPARK_HOME}/bin:${PATH}"
export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH"
export PYSPARK_PYTHON=python3