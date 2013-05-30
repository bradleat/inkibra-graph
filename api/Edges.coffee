#callbacks (err, doc, meta)

exports.Edge = class Edges
  ##TODO: Return edges in a generic 'edge' format
  constructor: (@_name) ->
    base = require('./Base').Base
    @Base = base.getInstance()
    @namespace = @Base.namespace
    @db = @Base.rdb
    @Edge =
      name: @_name
      from: ""
      to: ""
      strength: 0


  ##TODO: Union, Intersect, Diff
  ##TODO: Make sure both nodes exist
  link: (node1, node2, callback) ->
    @db.zincrby "#{@namespace}_edge:#{node1}", 1, node2, (err, res) ->
      if callback?
        callback err, res, null

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

