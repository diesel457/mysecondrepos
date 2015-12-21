ComponentPage = require '../../../core/componentPage'

module.exports = class CreateSlider extends ComponentPage
  name: 'pages:CreateSlider'
  view: require('./index.jade')
  style: require('./index.styl')
