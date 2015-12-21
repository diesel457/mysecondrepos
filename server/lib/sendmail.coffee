_ = require 'lodash'
conf = require 'nconf'
mailgunOptions =
  apiKey: conf.get('MAILGUN_KEY') || 'NO_KEY',
  domain: conf.get('MAILGUN_DOMAIN') || 'NO_DOMAIN'
mailgun = require('mailgun-js') mailgunOptions
emailConstants = require '../../constant/emails.yaml'

sendemail = (from, subject, text) ->
  mailData = {from, subject, text}
  mailData.to = 'mihailfasol@gmail.com'
  mailgun.messages().send mailData, (err, response, body) ->
    console.log err if err

module.exports =
  send: sendemail
