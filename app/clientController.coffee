BaseController = require '../core/base/baseController'
util = require './util'
_ = require 'lodash'

module.exports = class ClientController extends BaseController

  home: (params) ->
    @load 'cards', params
    @load 'informs'
    @load 'slider'
    @load 'filters'
    @subscribeModules ->
      @page.render 'pages:Home'

  createCard: ->
    @subscribeModules ->
      @page.render 'pages:CreateCard'

  createInform: ->
    @subscribeModules ->
      @page.render 'pages:CreateInform'

  createFilters: ->
    @subscribeModules ->
      @page.render 'pages:CreateFilter'

  createSlider: ->
    @load 'slider'
    @subscribeModules ->
      @page.render 'pages:CreateSlider'

  editInform: ->
    infoId = @model.get '$render.params.infoId'
    @load 'inform', infoId
    @subscribeModules ->
      @page.render 'pages:CreateInform'

  editCard: ->
    cardId = @model.get '$render.params.cardId'
    @load 'card', cardId
    @subscribeModules ->
      @page.render 'pages:CreateCard'

  catalogue: (params) ->
    @load 'cards', params
    @load 'filters'
    @subscribeModules ->
      @page.render 'pages:Catalogue'

  about: ->
    @subscribeModules ->
      @page.render 'pages:About'

  cardPage: ->
    cardId = @model.get '$render.params.cardId'
    @load 'card', cardId
    @subscribeModules ->
      @page.render 'pages:CardPage'

  admin: ->
    # cardId = @model.get '$render.params.cardId'
    # @load 'card', cardId
    @subscribeModules ->
      @page.render 'Admin'
