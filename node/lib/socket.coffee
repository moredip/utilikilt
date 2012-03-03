boot = (server)->
  io = require('socket.io').listen(server);


  open_socket = undefined
  reload_page = ->
    console.log 'reloading?'
    return unless open_socket?
    open_socket.emit( 'refresh', 'reload page please' )
    console.log 'reloaded'

  io.sockets.on 'connection', (socket)->
    open_socket = socket

  console.log( 'socks are UP!' )

  browser_proxy = 
    reload_page: reload_page
  browser_proxy

exports = module.exports = boot
