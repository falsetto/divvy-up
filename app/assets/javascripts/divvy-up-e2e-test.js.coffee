angular.module('divvyUpE2eTest', ['divvyUp', 'ngMockE2E'])
  .run ($httpBackend, $location) ->
    if $location.search().api_down
      $httpBackend.whenGET('bucket_groups').respond -> '500'

    $httpBackend.whenGET(/.*/).passThrough()
    $httpBackend.whenPOST(/.*/).passThrough()
    $httpBackend.whenPUT(/.*/).passThrough()
    $httpBackend.whenDELETE(/.*/).passThrough()
