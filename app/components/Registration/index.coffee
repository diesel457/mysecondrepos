DerbyLoginRegister = require 'derby-login/components/register'
superagent = require 'superagent'

module.exports = class Registration extends DerbyLoginRegister
  name: 'Registration'
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @fields = [
      'email'
      'firstName'
      'lastName'
      'password'
      'confirm'
    ]

  submit: ->
    data = {}
    @fields.forEach (field) =>
      data[field] = @model.get(field)
    DerbyLoginRegister::submit.call this, data

  send: (data) ->
    superagent
      .post '/api/login'
      .send data
      .end (err, res) =>
        if res.body.success
          @model.root.set '_session.logined', true
