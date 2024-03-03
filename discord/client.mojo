from discord.socket import Socket
from python import Python

struct Client:
    var token: String
    var app_id: String
    var base_url: String

    fn __init__(inout self, token: String, app_id: String = ''):
        self.token = token

        if app_id == '':
            # r = self._send(Request("GET", f"{API_BASE_URL}/users/@me"))
            # self._app_id = int(r.json()["id"])
            print("No app_id provided, fetching from token")
            # Fetch app_id from token
            # self.app_id = fetch_app_id(token)
            self.app_id = "0"
        else:
            self.app_id = app_id

        self.base_url = "https://discord.com/api/v10/applications/" + self.app_id

    fn run(self) raises -> None:
        var socket = Socket(self.token)
        socket.connect()

    fn register_command(self, command_data: String):
        var url = self.base_url + "/commands"
        var headers = Python.dict()
        try:
            headers["Authorization"] = "Bot " + self.token
            headers["Content-Type"] = "application/json"
        except:
            print("Failed to set headers")

        # ...

    fn register_server_command(self, command_data: String, server_id: String):
        var url = self.base_url + "/guilds/" + server_id + "/commands"
        var headers = Python.dict()
        try:
            headers["Authorization"] = "Bot " + self.token
            headers["Content-Type"] = "application/json"
        except:
            print("Failed to set headers")

        # ...