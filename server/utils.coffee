_ = require 'lodash'
conf = require 'nconf'
json2csv = require 'json2csv'

exports.isSuperAdmin = (user) ->
  adminEmails = conf.get 'ADMINS'
  userEmails = user.emails
  if _.intersection(adminEmails, userEmails).length > 0
    return true
  else
    return false

exports.jsonToCsv = (data, fields, done) ->
  json2csv {
    data: data
    fields: fields
  }, (err, csv) ->
    done(csv)
