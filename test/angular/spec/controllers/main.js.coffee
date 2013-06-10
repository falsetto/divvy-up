describe 'Controller: MainCtrl', ->

  fakeBucketGroupsResponse = [
    id: 1
    name:"default"
    amount:1000
  ]

  scope = null
  ctrl = null
  
  beforeEach module 'divvyUp', 'mockedBuckets'

  beforeEach inject ($controller, $http, $rootScope, bucketGroups, buckets, defaultBucketsJSON, serverSyncer) ->
    spyOn(bucketGroups, 'query').andCallFake (callback) ->
      callback(fakeBucketGroupsResponse)

    spyOn(buckets, 'query').andReturn(defaultBucketsJSON)
    spyOn(buckets, 'destroy')

    spyOn(serverSyncer, 'queueSync')

    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', $scope: scope

  it 'sets default $http Accept header to "application/json"', inject ($http) ->
    expect($http.defaults.headers.common.Accept).toBe 'application/json'

  it 'assigns buckets service to scope', inject (buckets) ->
    expect(scope.bucketsService).toEqual buckets

  it "assigns the current user's first bucket group to scope", ->
    expect(scope.bucketGroup).toEqual fakeBucketGroupsResponse[0]

  it "assigns the current user's buckets to scope", inject (defaultBucketsJSON) ->
    scope.$digest()
    expect(scope.buckets).toEqual(defaultBucketsJSON)

  it 'assigns a queueSync function to scope', ->
    expect(scope.queueSync).toEqual(jasmine.any(Function))

  describe 'queueSync function', ->
    it 'delegates to serverSyncer.queueSync if the model is valid', inject (serverSyncer) ->
      form = $valid: true
      model = {}
      scope.queueSync(form, model)
      expect(serverSyncer.queueSync).toHaveBeenCalledWith(model)

    it 'does not delegate to serverSyncer.queueSync if the model is invalid', inject (serverSyncer) ->
      form = $valid: false
      model = {}
      scope.queueSync(form, model)
      expect(serverSyncer.queueSync).not.toHaveBeenCalled()

  it 'assigns a destroyBucket function to scope', ->
    expect(scope.destroyBucket).toEqual(jasmine.any(Function))

  describe 'destroyBucket function', ->
    it 'delegates to buckets.destroy if $window.confirm is true', inject (buckets) ->
      spyOn(window, 'confirm').andReturn(true)
      bucket = {}
      scope.destroyBucket(bucket)
      expect(buckets.destroy).toHaveBeenCalledWith(bucket)

    it 'does not delegate to bucket.destroy if $window.confirm is false', inject (buckets) ->
      spyOn(window, 'confirm').andReturn(false)
      bucket = {}
      scope.destroyBucket(bucket)
      expect(buckets.destroy).not.toHaveBeenCalled()
