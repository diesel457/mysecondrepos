ComponentBase = require '../../../core/componentBase'
qs = require 'qs'

module.exports = class Filters extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    filters = @model.ref 'filters', @model.scope '_page.filters'
    for filter in filters.get()
      if filter.filterType is 'type'
        @model.push 'typeFilters', filter
      else if filter.filterType is 'material'
        @model.push 'materialFilters', filter
      else if filter.filterType is 'form'
        @model.push 'formFilters', filter

  getFilter: ->
    values =
      filters: @model.get 'filterCheck'
    @app.history.push '/catalogue?' + qs.stringify values
