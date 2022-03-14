import faust

app = faust.App('stream_joined', broker='kafka://localhost:9092')

topic = app.topic('stream1','stream2')

@app.agent(topic)
async def process(stream):
    async for key, value in stream.items():
        print(key, value)

if __name__ == '__main__':
    app.main()
