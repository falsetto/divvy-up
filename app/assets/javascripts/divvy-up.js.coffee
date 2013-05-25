angular.module('divvyUp', ['ngResource'])
  .config ($routeProvider, $locationProvider) ->
    $locationProvider.html5Mode true
    $routeProvider.when('/app',
      controller: 'MainCtrl',
      # templateUrl: '<%= asset_path('main.html') %>'
      templateUrl: '/assets/main.html'
    ).otherwise redirectTo: '/'
