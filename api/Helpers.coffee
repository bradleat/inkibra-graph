exports.Helpers = class Helpers
	base: (body) ->
		res =
			about: "INKIBRA GRAPH TEST BASE v#{require('../../package').version}"
			api: body

	format: (method_name, type, val) ->
		@base res =
			method:
				name: method_name
				return_type: type
			value: val

	error: (method_name, type, err, code) ->
		@base error =
			method:
				name: method_name
				return_type: type
			value: "ERROR"
			error:
				message: err
				debug: code
	
	Array_remove: (value) ->
		@[t..t] = [] if (t = @indexOf(value)) > -1

