RouteController = require 'local-derby-router/controller'

module.exports = class BaseController extends RouteController

  @useModules
    card: require('../modules/cardModule')
    cards: require('../modules/cardsModule')
    inform: require('../modules/informModule')
    informs: require('../modules/informsModule')
    slider: require('../modules/sliderModule')
    filters: require('../modules/filtersModule')

  @useFilters
