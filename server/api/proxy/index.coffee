'use strict'

express = require 'express'
controller = require './proxy.controller'

router = express.Router()

router.get '/', controller.index

module.exports = router
