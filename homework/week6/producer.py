from time import sleep
from json import dumps
import sys
from kafka import KafkaProducer

producer  = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    key_serializer=lambda x: dumps(x).encode('utf-8'),
    value_serializer=lambda x: dumps(x).encode('utf-8')
)


for e in range(10):
    key1 = e
    key2 = e
    data1 = {'number': 2*e}
    data2 = {'number': 3*e}

    producer.send('stream1', key = key1, value=data1)
    producer.send('stream2', key = key2, value=data2)
    print('producing')
    sleep(1)