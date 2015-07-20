"use strict"

mongoose = require("mongoose")
Promise = require("bluebird")
Promise.promisifyAll mongoose

Schema = mongoose.Schema

authTypes = ["producteca"]

UserSchema = new Schema
  name: String
  email:
    type: String
    lowercase: true
    required: true
    unique: true

  provider: String
  providerId: Number

  tokens:
    producteca: String

  settings:
    saved: Boolean
    mappings: Schema.Types.Mixed

module.exports = mongoose.model("User", UserSchema)
