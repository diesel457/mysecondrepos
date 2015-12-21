module.exports = class Popup
  view: require('./index.jade')
  style: require('./index.styl')


  open: (inputValue) ->
    @model.set 'visible', true
    @model.root.set '_page.popup.inputValue', inputValue

  hide: (event, element) ->
    if event.target == element
      @model.del 'visible'
      @model.root.del '_page.popup.inputValue'
      @emit 'cancel'

  xMark: ->
    @model.del 'visible'
    @model.root.del '_page.popup.inputValue'
