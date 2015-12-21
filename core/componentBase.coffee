module.exports = class ComponentBase
  init: ->
    @root = @page.root
    @model.ref 'root', @root.model
