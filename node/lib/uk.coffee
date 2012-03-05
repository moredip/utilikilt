publicDir = __dirname + "/../../public"
port = 3000

createServer = require './serve'
socket_server = require './socket'

app = createServer( publicDir, port )
browser = socket_server(app)

watcher = require('./watcher').createWatcher( publicDir )

watcher.onChange ->
  browser.reload_page()
