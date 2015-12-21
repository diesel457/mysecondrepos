ComponentPage = require '../../../core/componentPage'

module.exports = class About extends ComponentPage
  name: 'pages:About'
  view: require('./index.jade')
  style: require('./index.styl')
