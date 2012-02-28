connect = require 'connect'

app = connect()
  .use( connect.logger({ buffer: 500 }) )
  .use( (req,res,next)->
    console.log( 'handling ' + req )
    res.writeHead( 200, {'Content-Type':'text/html'} )
    res.end('<h1>werd from connect</h1>')
  )
app.listen( 3000 )

console.log('/u.\\ UtiliKilt has been donned!')
