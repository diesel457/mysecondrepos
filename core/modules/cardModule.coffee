module.exports =

  load: (cardId) ->
    @card = @model.at 'cards.' + cardId
    @_subscriptions.push @card

  setup: ->
    @model.ref '_page.card', @card
