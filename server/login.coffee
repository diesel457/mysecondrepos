module.exports =
  collection: 'auths'
  publicCollection: 'users'
  encryption: 'sha-1'
  hashField: 'passwordHash'

  successUrl: '/'
  confirmRegistration: false
  loginUrl: '/'

  user:
    id: true
    email: true
    # firstname: true
    # lastname: true
    # admin: true

  hooks: require('./login-hooks')
