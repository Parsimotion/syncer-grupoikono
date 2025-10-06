"use strict"

# Development specific configuration
# ==================================
process.env.PRODUCTECA_CLIENTID = 8
process.env.PRODUCTECA_CLIENTSECRET = 'secreto123123'
process.env.WEBJOB_SIGNATURE = 'coso!'
# process.env.MONGO_URI = 'NO_HARDCODED_SECRET_HERE'
process.env.NETSHOES_USER_ID = '560d96dd3dfd05404ef416fa'

module.exports =

  # MongoDB connection options
  mongo:
    uri: process.env.MONGO_URI or "mongodb://localhost/syncer-motomel-dev"
