#callbacks (err, doc, meta)

exports.Node = class Nodes
	constructor: () ->
		base = require('./Base').Base
		@Base = base.getInstance()
	
	insert: (id, doc, callback) ->
		@Base.rdb.hset "yo", "yo", "yo", callback

		
	
	#delete: (id, callback) ->

	#retrieve: (id, callback) ->

	#append: (id, doc, callback) ->

	#prepend: (id, doc, callback) ->

	#set: (id, doc, callback) ->

	#update: (id, doc, cas, callback) ->
