describe 'Controller: MainCtrl', ->
  
  # load the controller's module
  beforeEach module('divvyUp')
  MainCtrl = undefined
  scope = undefined

  http = defaults:
    headers:
      common: {}

  # Initialize the controller and a mock scope
  beforeEach inject(($controller) ->
    scope = {}
    MainCtrl = $controller('MainCtrl',
      $scope: scope
      $rootScope: scope
      $window: window
      $http: http
    )
  )

  it 'sets default $http Accept header to "application/json"', ->
    expect(http.defaults.headers.common.Accept).toBe 'application/json'
