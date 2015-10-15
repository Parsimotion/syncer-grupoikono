"use strict"

# Development specific configuration
# ==================================
process.env.PRODUCTECA_CLIENTID = 8
process.env.PRODUCTECA_CLIENTSECRET = 'secreto123123'
process.env.WEBJOB_SIGNATURE = 'coso!'
process.env.MONGO_URI = 'mongodb://parsimotion:Parsi2014@candidate.4.mongolayer.com:10392,candidate.3.mongolayer.com:10771/syncer-grupoikono?replicaSet=set-5595ac87819c302ed2000110'
process.env.NETSHOES_USER_ID = '560d96dd3dfd05404ef416fa'

module.exports =

  # MongoDB connection options
  mongo:
    uri: process.env.MONGO_URI or "mongodb://localhost/syncer-motomel-dev"
