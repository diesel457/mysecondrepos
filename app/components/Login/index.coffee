DerbyLogin = require 'derby-login/components/login'
superagent = require 'superagent'

module.exports = class Login extends DerbyLogin
  name: 'Login'
  view: require('./index.jade')
  style: require('./index.styl')
