ComponentBase = require '../../../core/componentBase'

module.exports = class BottomInformBox extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  create: ->
    scopeInforms = @model.scope '_page.informs'
    @model.start 'informBottom', scopeInforms, @_getBottomInform.bind(@)

  _getBottomInform: (informs) ->
    return unless informs
    top = null
    for informId, inform of informs
      if inform.type is 'bottom'
        top = inform
    top
