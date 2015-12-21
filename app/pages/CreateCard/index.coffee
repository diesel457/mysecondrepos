ComponentPage = require '../../../core/componentPage'

module.exports = class CreateCard extends ComponentPage
  name: 'pages:CreateCard'
  view: require('./index.jade')
  style: require('./index.styl')
