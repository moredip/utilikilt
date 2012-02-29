document.addEventListener 'DOMContentLoaded', ->
  script = document.createElement( 'script' )
  script.type = 'text/javascript'
  script.src = '/socket.io/socket.io.js'
  document.body.appendChild( script )

  nextTurn = ->
    if not io?
      setTimeout( nextTurn, 50)
      return

    socket = io.connect(window.location.protocol+"//"+window.location.host)
    socket.on 'refresh', (data)->
      console.log('refresh!',data)
#      window.location.reload()
  setTimeout( nextTurn, 1 )
