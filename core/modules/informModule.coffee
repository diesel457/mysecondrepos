module.exports =

  load: (infoId) ->
    @inform = @model.at 'informs.' + infoId
    @_subscriptions.push @inform

  setup: ->
    @model.ref '_page.inform', @inform
