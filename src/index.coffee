fs = require "fs"
path = require "path"
discount = require "discount"

regex = 
	markdownFile: /(.*)\.(md|markdown)$/

class AnnexHandler
	constructor: (@annex) ->
	init: (files, cb) ->
		@annex.addFileHandler "*.md", @processFile
		cb()
	processFile: (file, cb) =>
		self = @
		matches = regex.markdownFile.exec file
		outName = "#{matches[1]}.html"
		fs.readFile (@annex.pathTo file), "utf8", (err, contents) ->
			generated = discount.parse contents
			if layout = self.annex.config.layout
				self.annex.writePage outName, { layout: layout }, generated, cb
			else
				self.annex.writeFile outName, generated, cb
		return

module.exports = (annex) ->
	return (new AnnexHandler annex)

