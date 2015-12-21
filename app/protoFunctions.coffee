module.exports = (app) ->

  app.proto.layoutClass = (name) ->
    '_' + name.replace(/:/g, '-')

  app.proto.urlFilter = (url) ->
    return unless url
    filter = new RegExp(/([\da-z\.-]+)\.([a-z\.]{2,6})/)
    if filter.exec(url)?
      filter.exec(url)[0]

  app.proto.ogUrl = ->
    baseUrl = @model.get '_global.BASE_URL'
    url = @model.get '$render.url'
    if url is '/' or url.indexOf('get-started') > -1
      url = '/login'
    baseUrl + (url or '/login')
