describe 'bucketGroups Service', ->
  $httpBackend = null

  beforeEach module 'divvyUp'

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get('$httpBackend')
    $httpBackend.expectGET('bucket_groups').respond 200, [
      id: 1
      amount: 1000
      name: 'default'
    ]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'can query for bucket groups', inject (bucketGroups) ->
    bucketGroups.query()
    $httpBackend.flush()

  it 'can update a bucket group', inject (_bucketGroups_) ->
    bucketGroups = _bucketGroups_.query()
    $httpBackend.flush()

    $httpBackend.expectPUT('bucket_groups/1').respond 200

    bucketGroup = bucketGroups[0]
    bucketGroup.$update()
    $httpBackend.flush()
