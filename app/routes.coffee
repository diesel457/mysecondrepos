module.exports =

  general:
    _controller: require './clientController'

    home:              get: '/'
    createCard:        get: '/create/card'
    createInform:      get: '/create/inform/:type?'
    createSlider:      get: '/create/slider'
    createFilters:      get: '/create/filters'
    editInform:        get: '/edit/inform/:type/:infoId?'
    editCard:          get: '/edit/:cardId?'
    catalogue:         get: '/catalogue'
    about:             get: '/about'
    cardPage:          get: '/card/:cardId?'
    admin:             get: '/admin'
