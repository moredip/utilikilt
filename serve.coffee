express = require 'express'

htmlMangler = (req,res,next)->
  

htmlMangler = (req,res,next)->
  origWrite = res.write
  origEnd = res.end


  firstCall = true
  res.write = (chunk,encoding)->
    console.log('res.write')
    if firstCall
      origWrite.call(res,'<script type="text/javascript">window.alert("foo");</script>', encoding )
      firstCall = false
    origWrite.call(res,chunk,encoding)

  res.end = (chunk,encoding)->
    console.log('res.end')
    res.write( chunk, encoding ) if chunk?
    origEnd.call(res)
      

  next()


app = express.createServer()
  .use( express.logger({ buffer: 500 }) )
  .use( htmlMangler )
  .use(express.static(__dirname + '/public'))
app.listen( 3000 )

console.log('/u.\\ UtiliKilt UP!')
