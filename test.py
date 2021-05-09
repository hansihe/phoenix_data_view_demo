import phxsocket
import time

socket = phxsocket.Client("ws://localhost:4000/data/websocket", {"foo": "connect info"})

if socket.connect():
    print("connected!")

    channel = socket.channel("dv:c:1", {"r": ["/hello_world", {}]})
    channel.on("f", lambda v: print(v))

    resp = channel.join()
    print("joined!", resp)

    while True:
        time.sleep(1000)
