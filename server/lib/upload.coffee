multiparty = require 'multiparty'
util = require 'util'
fs = require 'fs'
_ = require 'lodash'
path = require 'path'

module.exports =
  upload: (req, res, next) ->
    form = new (multiparty.Form)
    form.parse req, (err, fields, files) ->
      fileName = _.last(files.uploadFile[0].path.split('/'))
      fs.readFile files.uploadFile[0].path, (err, data) ->
        newPath = path.join(__dirname, '../../public/project-image/', fileName)
        fs.writeFile newPath, data, (err) ->
          obj = {}
          obj.path = newPath
          obj.name = fileName
          res.send obj
