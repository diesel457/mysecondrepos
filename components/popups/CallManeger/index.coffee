superagent = require 'superagent'
constantEmails = require '../../../constant/emails.yaml'

module.exports = class CallManeger
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.ref 'confirm', @model.scope '_page.confirmMassege'

  sendEmail: ->
    params =
      name: @model.get 'name'
      email: @model.get 'email'
      telephone: @model.get 'telephone'
      cardId: @model.root.get '_page.popupCardId'

    text = _.template(constantEmails.templates.user) params

    form =
      from: params.email
      subject: 'Sapak'
      text: text

    superagent
      .post '/service/sendEmail'
      .send form
      .end (err, res) =>
        @model.root.set '_page.confirmMassege', true
