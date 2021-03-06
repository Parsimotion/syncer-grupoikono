'use strict'

angular.module 'syncer-motomel-app'
.factory 'Auth', ($location, $rootScope, $http, User, $cookieStore, $q) ->
  currentUser = User.get()

  ###
  Gets all available info on authenticated user

  @return {Object} user
  ###
  getCurrentUser: ->
    currentUser
