"use strict"

request = require("request")

options =
  url: "https://syncer-grupoikono.azurewebsites.net/api/hooks/webjob/resetstock"
  headers: signature: process.env.WEBJOB_SIGNATURE
  body: userId: process.env.WOOW_USER_ID
  json: true

request.post options, (err, result) ->
  console.log err
  console.log result

