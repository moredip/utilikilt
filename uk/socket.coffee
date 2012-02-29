boot = (server)->
  io = require('socket.io').listen(server);

  io.sockets.on 'connection', (socket)->
    ping = -> 
      socket.emit( 'refresh', 'ppping' )
      setTimeout( ping, 2000 )
    setTimeout( ping, 2000 )

  console.log( 'socks are UP!' )

exports = module.exports = boot
