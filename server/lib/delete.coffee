multiparty = require 'multiparty'
util = require 'util'
fs = require 'fs'
_ = require 'lodash'
path = require 'path'

module.exports =
  delete: (req, res, next) ->
    form = new (multiparty.Form)
    form.parse req, (err, fields, files) ->
      filePath = path.join(__dirname, '../../public/project-image/', fields.deleteFile[0])
      fs.unlink filePath, (err) ->
        obj = {}
        obj.delete = 'true'
        res.send obj
