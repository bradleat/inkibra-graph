require('coffee-script')
Node = require('./api/Nodes').Node
Edge = require('./api/Edges').Edge

exports.InkibraGraph = class InkibraGraph
  constructor: ->
    version = require('./package.json').version
    console.log "Loading Inkibra Graph Version #{version}"
    @Node = new Node()
    console.log "Inkibra Graph Loaded"
    
  test: () ->
    true

  register: (verb) ->
    if @[verb]?
      return false

    @[verb] = new Edge(verb)
    if @[verb]?
      return true
    else
      return false

  unregister: (verb) ->
    if @[verb]?
      @[verb] = null
      return true
    else
      return false

  is_registered: (verb) ->
    if @[verb]?
      return true
    else
      return false
