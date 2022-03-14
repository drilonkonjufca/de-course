import faust

app = faust.App('stream_joined', broker='kafka://localhost:9092')

topic1 = app.topic('stream1')
topic2 = app.topic('stream2')


@app.agent(topic1)
async def start_reading(records):
    async for record in records:
        print(record)


if __name__ == '__main__':
    app.main()
