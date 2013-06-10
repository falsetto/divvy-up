describe 'serverSyncer service', ->
  $httpBackend = null

  beforeEach module 'divvyUp', 'mockedBuckets'

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get('$httpBackend')

  describe '.queueSync', ->
    buckets = null

    beforeEach inject (_buckets_, defaultBucketsJSON) ->
      $httpBackend.whenGET('bucket_groups/1/buckets')
        .respond 200, defaultBucketsJSON
      buckets = _buckets_.query id: 1
      $httpBackend.flush()

    afterEach ->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

    it "queues a delayed call to the passed object's $update method",
      inject ($timeout, serverSyncer) ->
        $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200
        serverSyncer.queueSync(buckets[0])
        $timeout.flush()
        $httpBackend.flush()

    it 'only allows one $update call per object in the queue at a time',
      inject ($timeout, serverSyncer) ->
        $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200
        serverSyncer.queueSync(buckets[0])
        serverSyncer.queueSync(buckets[0])
        $timeout.flush()
        $httpBackend.flush()
