ComponentBase = require '../../../core/componentBase'

module.exports = class CardIndex extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.ref 'card', @model.scope '_page.card'
    @model.set 'imageIndex', 0

  changeImage: (index) ->
    @mainImage.className = ''
    setTimeout =>
      @mainImage.className = '-active'
    , 200
    @model.set 'imageIndex', index

  open: (popupCardId) ->
    @model.root.set '_page.popupCardId', popupCardId
    @page.popups.callManeger.open()
