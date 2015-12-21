ComponentPage = require '../../../core/componentPage'

module.exports = class CreateFilter extends ComponentPage
  name: 'pages:CreateFilter'
  view: require('./index.jade')
  style: require('./index.styl')
