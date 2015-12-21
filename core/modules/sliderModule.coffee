module.exports =

  load: ->
    @slider = @model.at 'slider'
    @_subscriptions.push @slider

  setup: ->
    @model.ref '_page.slider', @slider.filter()
