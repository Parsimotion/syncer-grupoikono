"use strict"

request = require("request")

exports.synchronize = (userId) ->
  options =
    url: "https://syncer-grupoikono.azurewebsites.net/api/hooks/webjob"
    headers: signature: process.env.WEBJOB_SIGNATURE
    body: userId: userId
    json: true

  request.post options, (err, result) ->
    console.log err
    console.log result

