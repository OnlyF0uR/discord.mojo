from discord.modules import PyModules
from time import sleep
from algorithm import parallelize
from python import PythonObject
from python import Python

struct Socket:
    var _modules: PyModules
    var _ws: PythonObject
    var token: String

    fn __init__(inout self, token: String) raises -> None:
        self._modules = PyModules()
        self._ws = self._modules.websocket.WebSocket()
        self.token = token

    fn connect(self) raises -> None:
        _ = self._ws.connect("wss://gateway.discord.gg/?v=6&encoding=json")

        # Receive event
        var event_raw = self._ws.recv()
        if event_raw is not None:
            var event = self._modules.json.loads(event_raw)

            # Start heartbeat
            var heartbeat_interval = event["d"]["heartbeat_interval"] / 1000
            fn wrapper(ws: PythonObject, hb: Int) raises:
                print("Starting heartbeat: ", hb)
                @parameter
                fn worker(row: Int):
                    while True:
                        try:
                            _ = ws.send('{"op": 1, "d": null}')
                            print("Heartbeat sent")
                        except:
                            print("Heartbeat failed")

                        sleep(hb)

                parallelize[worker](1)
                print("Heartbeat stopped")

            wrapper(self._ws, int(heartbeat_interval.to_float64())) # Was the only way to convert to int from python float?

            # Identify
            # TODO: Implement identify