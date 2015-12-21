ComponentBase = require '../../../core/componentBase'

module.exports = class Card extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    cardId = @model.get 'cardId'
    @model.ref 'card', @model.scope "cards.#{cardId}"
    @model.set 'cardImg', @model.get 'card.images.0'

  open: (popupCardId) ->
    @model.root.set '_page.popupCardId', popupCardId
    @page.popups.callManeger.open()
