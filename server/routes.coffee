###*
Main application routes
###
"use strict"
errors = require("./components/errors")
auth = require("./auth/auth.service")

module.exports = (app) ->
  # Insert routes below
  app.get "/", (req, res) ->
    if req.isAuthenticated()
      res.sendfile app.get("appPath") + "/main.html"
    else
      res.sendfile app.get("appPath") + "/landing.html"

  app.use "/api/users", require("./api/user")
  app.use "/api/hooks/webjob", require("./api/hooks/webjob")
  app.use "/api/settings", require("./api/settings")
  app.use "/auth", require("./auth")
  app.get "/logout", auth.logout

  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get errors[404]

  # All other routes should redirect to the index.html
  app.route("/*").get (req, res) ->
    res.sendfile "server/index.html"
    return
