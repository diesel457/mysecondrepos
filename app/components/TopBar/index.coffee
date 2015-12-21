ComponentBase = require '../../../core/componentBase'
qs = require 'qs'

module.exports = class TopBar extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  activeClass: (params) ->
    url = @model.scope('$render.params.url').get().split('?')[0]
    if params is url
      return '-active'

  globalSearch: ->
    globalSearch =
      search: @model.get 'search'

    @app.history.push '/catalogue?' + qs.stringify globalSearch
