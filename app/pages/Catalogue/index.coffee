ComponentPage = require '../../../core/componentPage'

module.exports = class Catalogue extends ComponentPage
  name: 'pages:Catalogue'
  view: require('./index.jade')
  style: require('./index.styl')
