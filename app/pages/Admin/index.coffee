ComponentPage = require '../../../core/componentPage'

module.exports = class Admin extends ComponentPage
  name: 'Admin'
  view: require('./index.jade')
  style: require('./index.styl')
