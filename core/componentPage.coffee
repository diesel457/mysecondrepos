# util = require 'dm-util'
#
# initFb = ->
#   FB.init
#     appId: @model.scope('_global.FACEBOOK_KEY').get()
#     version: 'v2.3'
#   FB.getLoginStatus (response) ->

module.exports = class ComponentPage
  init: ->
    @page.root = this
  #
  # create: ->
  #   hash = Math.random().toString(36).substring(7)
  #   util.getScript '/js/fb.js#' + hash, initFb
