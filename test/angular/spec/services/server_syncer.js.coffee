describe 'serverSyncer service', ->
  $httpBackend = null
  bucketsResponse = [
    id: 1
    bucket_group_id: 1
    name: 'tithe'
    percentage: 0.1
  ,
    id: 2
    bucket_group_id: 1
    name: 'mortgage'
    percentage: 0.15
  ,
    id: 3
    bucket_group_id: 1
    name: 'fun'
    percentage: 0.05
  ]

  beforeEach module 'divvyUp'

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get('$httpBackend')

  describe '.queueSync', ->
    buckets = null

    beforeEach inject (_buckets_) ->
      $httpBackend.whenGET('bucket_groups/1/buckets')
        .respond 200, bucketsResponse
      buckets = _buckets_.query
        bucket_group_id: 1
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
