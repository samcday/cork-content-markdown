glob = require "glob"
discount = require "discount"

class AnnexHandler
	constructor: (@cork, @config) ->
	init: (files, cb) ->
		@files = files
		cb()
	listPages: (cb) ->


module.exports = (cork, annexRoot) ->
	return (new AnnexHandler cork, annexRoot)
