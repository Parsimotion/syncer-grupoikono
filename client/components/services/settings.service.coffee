app.factory "Settings", ($resource) ->
  $resource "/api/settings", {},
    query:
      isArray: false
      transformResponse: (data) ->
        settings = JSON.parse data
        settings

    update:
      method: "PUT"
      transformRequest: (settings) ->
        JSON.stringify settings
