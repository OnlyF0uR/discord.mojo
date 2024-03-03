from python import Python, PythonObject

struct PyModules:
    var websocket: PythonObject
    var json: PythonObject

    fn __init__(inout self) raises -> None:
        self.websocket = self.__load_websocket_module()
        self.json = self.__load_json_module()

    @staticmethod
    fn __load_websocket_module() raises -> PythonObject:
        var websocket = Python.import_module("websocket") # websocket-client
        return websocket

    @staticmethod
    fn __load_json_module() raises -> PythonObject:
        var json = Python.import_module("json")
        return json