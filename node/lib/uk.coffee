# first arg is `node` (or actually `coffee` in our case), second arg is script name, third arg is the one we want
publicDir = require('path').resolve( process.argv[2] )
port = process.argv[3] || 3000

console.log( "Launching a server for #{publicDir} on port #{port}" )

createServer = require './serve'
socket_server = require './socket'

app = createServer( publicDir, port )
browser = socket_server(app)

watcher = require('./watcher').createWatcher( publicDir )

watcher.onChange ->
  browser.reload_page()
