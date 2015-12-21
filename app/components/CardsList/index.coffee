ComponentBase = require '../../../core/componentBase'

module.exports = class CardsList extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.ref 'cardIds', @model.scope '_page.cardIds' 
