module.exports =

  load: ->
    @filters = @model.at 'filters'
    @_subscriptions.push @filters

  setup: ->
    @model.ref '_page.filters', @filters.filter()
