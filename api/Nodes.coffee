#callbacks (err, doc, meta)

exports.Node = class Nodes
  constructor: () ->
    base = require('./Base').Base
    @Base = base.getInstance()
    @namespace = @Base.namespace
    @db = @Base.rdb
  
  insert: (id, doc, callback) ->
    @db.hsetnx "#{@namespace}_node:#{id}", 'json', doc, (err, res) ->
      if callback?
        callback err, res, null

  exists: (id, callback) ->
    @db.exists "#{@namespace}_node:#{id}", (err, res) ->
      if callback?
        if res is 1
          res = true
        else if res is 0
          res = false
        callback err, res, null
  
  #delete: (id, callback) ->
    #we have to unlink the hash first

  retrieve: (id, callback) ->
    @db.hget "#{@namespace}_node:#{id}", 'json', (err, res) ->
      if callback?
        if not res?
          res = false
        callback err, res, null

  #append: (id, doc, callback) ->

  #set: (id, doc, callback) ->

  #update: (id, doc, cas, callback) ->
