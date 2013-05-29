@include = ->
	console.log "Loading Dev Environment"
	
	# settings

	@enable 'databag' #gives our views an object @params with qs, body, params

	# middleware use stack	

	@use @express.logger()	#logs everything for us
	#@use @express.compress() #compresses response data
	@use @express.bodyParser() #parses requests bodies so we can use them later
	@use @express.methodOverride() #gets us all of our HTML VERBS
	@use @app.router #does our routing for get, put, delete, post, etc
	@use errorHandler:
		dumpExceptions: true
		showStack: true
	
