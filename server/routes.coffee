express = require 'express'
serverController = require './serverController'
router = express.Router()

router.post '/api/upload', serverController.upload

router.post '/api/login', serverController.register

router.post '/api/delete', serverController.delete

router.post '/service/sendEmail', serverController.email

module.exports = router
