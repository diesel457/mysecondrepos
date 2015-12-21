ComponentBase = require '../../../core/componentBase'
_ = require 'lodash'
inputs =
  producer:
    label: 'Производитель'
    key: 'producer'
  type:
    label: 'Тип'
    key: 'type'
  material:
    label: 'Материал'
    key: 'material'
  form:
    label: 'Форма'
    key: 'form'
  length:
    label: 'Длина'
    key: 'length'
  width:
    label: 'Ширина'
    key: 'width'
  height:
    label: 'Высота'
    key: 'height'
  capacity:
    label: 'Объём'
    key: 'capacity'

module.exports = class CreateForm extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @cardId = @model.root.get '$render.params.cardId'

    unless @cardId
      @model.set 'optionsArray', _.filter inputs
    else
      @model.ref 'card', @model.scope "cards.#{@cardId}"
      @model.set 'optionsArray', _.filter @model.get 'card.options'

  createCard: ->
    card = @model.get 'card'
    options = @model.get 'optionsArray'
    card.options = options

    unless @cardId
      @model.root.add 'cards', card, =>
        @app.history.push '/'
    else
      @app.history.push '/'
