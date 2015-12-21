ComponentBase = require '../../../core/componentBase'

module.exports = class CreateFormInform extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.ref 'type', @model.scope '$render.params.type'
    inform = @model.ref 'inform', @model.scope '_page.inform'
    description = @model.del 'inform.description'
    if description
      inform.at('description').set description.join('\n')

  createInformBox: ->
    topInform = @model.get 'inform'
    topInform.type = @model.root.get '$render.params.type'

    topInform.description = @model.get('inform.description').split('\n')

    unless @inform
      @model.root.add 'informs', topInform, =>
        @app.history.push '/'
    else
      @app.history.push '/'
