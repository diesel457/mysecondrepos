_ = require 'lodash'
conf = require 'nconf'
crypto = require 'crypto'

registerAuths = (model, firstName, lastName, email, password, confirm) ->

	makeSalt = ->
	  len = 10
	  crypto.randomBytes(Math.ceil(len / 2)).toString("hex").substring 0, len

	encryptPassword = (password, salt) ->
  	crypto.createHmac("sha1", salt).update(password).digest "hex"

	salt = makeSalt()

	userData =
		firstName: firstName
		lastName: lastName
		email: email
		passwordHash: encryptPassword(password, salt)

	model.add 'auths', userData

module.exports =
  send: registerAuths
