angular.module('divvyUp', ['ngResource'])
  # TODO: Enable once next release of Angular is made (and includes
  # this new functionality)
  # .factory('timeoutHttpIntercept', ->
  #   request: (config) ->
  #     config.timeout = 5000
  #     config
  # )
  .config ($locationProvider, $routeProvider) ->
    # TODO: Enable once next release of Angular is made (and includes
    # this new functionality)
    # $httpProvider.interceptors.push 'timeoutHttpIntercept'
    $locationProvider.html5Mode true
    $routeProvider.when '/app',
      controller: 'MainCtrl'
      templateUrl: '/assets/main.html'
