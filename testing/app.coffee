require('zappajs') {
  port: require('./config.json').config.port
}, ->
  
  @configure
    development: =>
      @include './config/development.coffee'
    production: =>
      @include './config/production.coffee'
  
  InkibraGraph = require('../app').InkibraGraph
  
  @graph = new InkibraGraph()
  
  console.log "register #{@graph.register 'likes'}"
  
  @graph.likes.link "brad", 'wood', (err, res) ->
    console.log "links #{res}"

  @include './routes.coffee'

