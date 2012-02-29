app = require './serve'
socket_server = require './socket'

browser = socket_server(app)

watcher = require('./watcher').createWatcher( __dirname + "/../public" )

#watcher.on_change ->
  #browser.reload_page()
