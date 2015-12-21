ComponentBase = require '../../../core/componentBase'

module.exports = class CreateFormFilter extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  addFilter: (type) ->
    value = @model.del type
    @model.push 'filters.' + type, value

  createFilters: ->
    filters = @model.del 'filters'
    return unless filters
    for key, subFilters of filters
      for filter in subFilters
        obj = {}
        obj.filterName = filter
        obj.filterType = key
        @model.root.add 'filters', obj, =>
          @app.history.push '/'
