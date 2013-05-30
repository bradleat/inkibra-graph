#callbacks (err, doc, meta)
class Singleton
  _instance = null

  @getInstance: ->
    if not _instance?
      _instance = new @()
    return _instance

exports.Base = class Base extends Singleton
    constructor: ->
      @redis = require('redis')
      @rdb = @redis.createClient()
      @namespace = require('../package.json').config.namespace
