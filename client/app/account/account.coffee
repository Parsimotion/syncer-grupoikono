'use strict'

angular.module 'syncer-motomel-app'
.config ($stateProvider) ->
  $stateProvider
  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'

  .state 'settings.step1',
    url: '/step1'
    templateUrl: 'app/account/settings/settings-step1.html'

  .state 'settings.step2',
    url: '/step2'
    templateUrl: 'app/account/settings/settings-step2.html'
