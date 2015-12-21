ComponentPage = require '../../../core/componentPage'

module.exports = class CardPage extends ComponentPage
  name: 'pages:CardPage'
  view: require('./index.jade')
  style: require('./index.styl')
