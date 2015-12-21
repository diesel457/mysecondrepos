fs = require 'fs'
conf = require 'nconf'
superagent = require 'superagent'
moment = require 'moment-timezone'
utils = require './utils'
uploadImage = require './lib/upload'
deleteImage = require './lib/delete'
registerUser = require './lib/register'
sendmail = require './lib/sendmail'

module.exports =

  upload: uploadImage.upload
  delete: deleteImage.delete

  email: (req, res) ->
    { from, subject, text } = req.body

    sendmail.send from, subject, text

    res.send 200

  register: (req, res) ->
    model = req.getModel()

    { firstName, lastName, email, password, confirm } = req.body

    registerUser.send model, firstName, lastName, email, password, confirm

    res.json {success: true}
