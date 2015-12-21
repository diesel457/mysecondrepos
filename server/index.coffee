derbyServer = require 'local-derby-server'
express = require 'express'
conf = require 'nconf'

derbyServer.init().run

  app: require '../app'
  hooks: require './hooks'
  login: require './login'
  loginUrl: '/'

, (ee, options) ->

  ee.on 'routes', (expressApp) ->
    expressApp.use require './routes'
