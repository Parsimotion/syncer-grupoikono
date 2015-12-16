"use strict"
express = require("express")
controller = require("./webjob.controller.coffee")

router = express.Router()

router.post "/", controller.notification
router.post "/resetstock", controller.resetStock

module.exports = router
