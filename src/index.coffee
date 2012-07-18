fs = require "fs"
path = require "path"
discount = require "discount"

regex = 
	markdownFile: /(.*)\.md$/

class AnnexHandler
	constructor: (@annex) ->
	init: (files, cb) ->
		@files = files
		cb()
	processFile: (file, cb) ->
		self = @
		if matches = regex.markdownFile.exec file
			outName = "#{matches[1]}.html"
			fs.readFile (path.join @annex.root, file), "utf8", (err, contents) ->
				generated = discount.parse contents
				if layout = self.annex.config.layout
					self.annex.writeContent outName, { layout: layout }, generated, cb
				else
					self.annex.writeFile outName, generated, cb
			return
		cb()

module.exports = (annex) ->
	return (new AnnexHandler annex)
