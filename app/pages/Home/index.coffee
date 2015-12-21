ComponentPage = require '../../../core/componentPage'

module.exports = class Home extends ComponentPage
  name: 'pages:Home'
  view: require('./index.jade')
  style: require('./index.styl')
