ComponentBase = require '../../../core/componentBase'

module.exports = class CatolugueSideBar extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    filters = @model.ref 'filters', @model.scope '_page.filters'
    paramsFilters = @model.ref 'paramsFilters', @model.scope '$render.query.filters'
    @model.ref 'activeBtn', @model.scope '_page.activeBtn'

    for filter in filters.get() or []
      if filter.filterType is 'type'
        @model.push 'typeFilters', filter
      else if filter.filterType is 'producer'
        @model.push 'producerFilters', filter
      else if filter.filterType is 'material'
        @model.push 'materialFilters', filter
      else if filter.filterType is 'form'
        @model.push 'formFilters', filter

    #
    # filters = @model.ref 'filters', @model.scope '_page.filters'
    #
    # console.log activeFilters
    #






















  openFilter: (name) ->
    activeFolders = @model.get 'activeBtn'
    active = false

    if activeFolders
      for activeItem, index in activeFolders or []
        if activeItem is name
          active = true
          indexItem = index

    unless active
      @model.push 'activeBtn', name
    else
      @model.remove 'activeBtn', indexItem

  openClass: (array, name) ->
    if array
      if name in array
        return '-open'
