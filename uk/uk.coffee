app = require './serve'
socket_server = require './socket'

browser = socket_server(app)

watcher = require('./watcher').createWatcher( __dirname + "/../public" )

watcher.onChange ->
  browser.reload_page()
