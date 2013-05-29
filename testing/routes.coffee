@include = ->
	@helper route: (_class, method) ->
		Controller = require("../api/#{_class}.coffee").Controller
		new Controller(@qc())[method]()
	
	@helper qc: -> #quick cache
		cache =
			params: @params
			res: @res
			cb: @app.cb
	
	@helper base: (body) ->
		res =
			about: "INKIBRA GRAPH TEST v#{require('../package').version}"
			api: body
	
	@helper format: (method_name, type, val) ->
		@base res =
			method:
				name: method_name
				return_type: type
			value: val

	@helper error: (method_name, type, err, code) ->
		@base error =
			method:
				name: method_name
				return_type: type
			value: "ERROR"
			error:
				message: err
				debug: code

	
	
	# API BASE
	@get '/': ->
		@res.send @base "BASE"
