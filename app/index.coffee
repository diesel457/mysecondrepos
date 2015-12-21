derby = require 'derby'
app = module.exports = derby.createApp 'app', __filename

require('./styles/index.styl')

#Page Components
app.component require './pages/Home'
app.component require './pages/CreateCard'
app.component require './pages/Catalogue'
app.component require './pages/About'
app.component require './pages/CardPage'
app.component require './pages/Admin'
app.component require './pages/CreateInform'
app.component require './pages/CreateSlider'
app.component require './pages/CreateFilter'

#Local Components
app.component require './components/TopBar'
app.component require './components/Upload'
app.component require './components/TopInformBox'
app.component require './components/BottomInformBox'
app.component require './components/Filters'
app.component require './components/CardsList'
app.component require './components/CatolugueSideBar'
app.component require './components/Card'
app.component require './components/Slider'
app.component require './components/CreateForm'
app.component require './components/CreateFormInform'
app.component require './components/CreateSliderForm'
app.component require './components/CardIndex'
app.component require './components/Registration'
app.component require './components/Login'
app.component require './components/CreateFormFilter'
app.component require './components/Footer'

#Global Components
app.component require '../components/Popup'
app.component require '../components/popups/CallManeger'


# Prototype functions
protoFunctions = require('./protoFunctions')(app)

if window?
  global.app = app
  global.model = app.model

app.loadViews require('./views/index.jade')

# Ready
require('../core/ready') app

app.on 'routeDone', ->
  return if app.derby.util.isServer
  window?.scrollTo(0, 0)

# Client routes
app.use require('local-derby-router'), require('./routes')
