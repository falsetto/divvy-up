angular.module('divvyUp', ['ngResource'])
  # TODO: Enable once next release of Angular is made (and includes
  # this new functionality)
  # .factory('timeoutHttpIntercept', ->
  #   request: (config) ->
  #     config.timeout = 5000
  #     config
  # )
  .config ($httpProvider, $locationProvider, $routeProvider) ->
    # TODO: Enable once next release of Angular is made (and includes
    # this new functionality)
    # $httpProvider.interceptors.push 'timeoutHttpIntercept'
    $httpProvider.responseInterceptors.push ($q, $rootScope) ->
      (promise) ->
        promise.then(
          (successResponse) -> successResponse
          (errorResponse) ->
            $rootScope.apiError = errorResponse
            $q.reject(errorResponse)
        )

    $locationProvider.html5Mode true
    $routeProvider.when '/app',
      controller: 'MainCtrl'
      templateUrl: '/assets/main.html'
