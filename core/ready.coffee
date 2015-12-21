universitiesConstant = require '../constant/universities.yaml'

# [DEV] Model shortcuts
initDevHelpers = (model) ->
  window.model = model
  for fnName in ['get', 'set', 'query', 'fetch', 'subscribe']
    window[fnName] = Function.prototype.bind.call model[fnName], model

module.exports = (app) ->
  app.on 'ready', ->
    # DEBUG mode
    initDevHelpers(@model)

    # Remove Facebook _=_ hash
    if window.location.hash and window.location.hash == '#_=_'
      history.pushState '', document.title, window.location.pathname
