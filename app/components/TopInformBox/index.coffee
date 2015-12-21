ComponentBase = require '../../../core/componentBase'

module.exports = class TopInformBox extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  create: ->
    scopeInforms = @model.scope '_page.informs'
    @model.start 'informTop', scopeInforms, @_getTopInform.bind(@)

  _getTopInform: (informs) ->
    return unless informs
    top = null
    for informId, inform of informs
      if inform.type is 'top'
        top = inform
    top
