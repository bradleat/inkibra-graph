#callbacks (err, doc, meta)

exports.Edge = class Edges
  ##TODO: Return edges in a generic 'edge' format
  constructor: (@_name) ->
    Base = require('./Base').Base
    @Base = Base.getInstance()
    @namespace = @Base.namespace
    Node = require('./Nodes').Node
    @Node = new Node()
    @db = @Base.rdb
    @Edge =
      name: @_name
      from: ""
      to: ""
      strength: 0


  ##TODO: Union, Intersect, Diff
  link: (node1, node2, callback) ->
    node1_exists = false
    node2_exists = false
    _Node = @Node
    _db = @db
    _namespace = @namespace

    _Node.exists node1, (err, res1) ->
        node1_exists = res1
      _Node.exists node2, (err, res2) ->
          node2_exists = res2
          if node1_exists is true and node2_exists is true
            _db.zincrby "#{_namespace}_edge:#{node1}", 1, node2, (err, res) ->
              if callback?
                callback err, res, null
              else if callback?
                callback 'ERROR', false, null

  delink: (node1, node2, callback) ->
    @db.zincrby "#{@namespace}_edge:#{node1}", -1, node2, (err, res) ->
      if callback?
        callback err, res, null
  
  unlink: (node1, node2, callback) ->
    @db.zren "#{@namespace}_edge:#{node1}", node2, (err, res) ->
      if callback?
        callback err,res, null
  
  
  between: (node, start, end, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", start, end, 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", start, end]
    
    @db.zrevrange args, (err, res) ->
      if callback?
        callback err, res, null

  strongest: (node, num, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", 0, num - 1, 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", 0, num -1 ]
    
    @db.zrevrange args, (err, res) ->
      if callback?
        callback err, res, null
  
  weakest: (node, num, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", 0, num - 1, 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", 0, num -1 ]
    
    @db.zrange args, (err, res) ->
      if callback?
        callback err, res, null
  
  _unsafe_all: (node, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", '+inf', '-inf', 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", '+inf', '-inf']
    
    @db.zrevrangebyscore args, (err, res) ->
      if callback?
        callback err, res, null

  strengthAbove: (node, above, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", '+inf', above + 1, 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", '+inf', above + 1]
    
    @db.zrevrangebyscore args, (err, res) ->
      if callback?
        callback err, res, null
  
  strengthUnder: (node, under, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", under - 1, '-inf', 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", under -1 , '-inf']
    
    @db.zrevrangebyscore args, (err, res) ->
      if callback?
        callback err, res, null
  
  strengthBetween: (node, high, low, withscores, callback) ->
    if withscores
      args = ["#{@namespace}_edge:#{node}", high, low, 'WITHSCORES']
    else
      args = ["#{@namespace}_edge:#{node}", high, low]
    
    @db.zrevrangebyscore args, (err, res) ->
      if callback?
        callback err, res, null

  has: (node1, node2, callback) ->
    @db.zrank "#{@namespace}_edge:#{node1}", node2, (err, res) ->
      if callback?
        if not res?
          res = false
        callback err, res, null

