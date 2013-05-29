require('coffee-script')
Node = require('./api/Nodes').Node
exports.InkibraGraph = class Api
	constructor: ->
		console.log "Loading Inkibra Graph"
		@Node = new Node()
		console.log "Inkibra Graph Loaded"
