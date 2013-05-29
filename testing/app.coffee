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
  @graph.Node.insert("yo", "yo")
  
  @include './routes.coffee'

