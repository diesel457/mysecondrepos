module.exports =

  load: ->
    @informs = @model.at 'informs'
    @_subscriptions.push @informs

  setup: ->
    @model.ref '_page.informs', @informs
