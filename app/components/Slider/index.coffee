ComponentBase = require '../../../core/componentBase'

module.exports = class Slider extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.ref 'slider', @model.scope '_page.slider'
    @model.set 'active', 0

  choiceSlide: (index) ->
    @model.set 'active', index
