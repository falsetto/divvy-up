angular.module('divvyUp', ['ngResource'])
  .config ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode true
    $routeProvider.when '/app',
      controller: 'MainCtrl'
      templateUrl: '/assets/main.html'
