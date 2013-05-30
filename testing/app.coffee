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
  
  @graph.Node.insert "brad", "{ :", (err, res) ->
    console.log res

  @graph.Node.insert "wood", "", (err, res) ->
    console.log res

  console.log @graph.register 'likes'
  
  @graph.likes.link 'brad', 'tom', (err, res) ->
    console.log res

  @graph.likes.has 'brad', 'jack', (err, res) ->
    console.log res
  
  @include './routes.coffee'

