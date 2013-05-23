describe 'buckets Service', ->
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

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'can query for buckets', inject (buckets) ->
    $httpBackend.expectGET('bucket_groups/1/buckets')
      .respond 200, bucketsResponse
    buckets.query
      bucket_group_id: 1
    $httpBackend.flush()

  it 'can create a new bucket', inject (_buckets_) ->
    $httpBackend.expectGET('bucket_groups/1/buckets')
      .respond 200, bucketsResponse
    buckets = _buckets_.query
      bucket_group_id: 1
    $httpBackend.flush()

    $httpBackend.expectPOST('bucket_groups/1/buckets').respond 200

    bucketsLengthBeforeCreate = buckets.length
    _buckets_.create
      id: 1
    bucketsLengthAfterCreate = buckets.length
    expect(bucketsLengthAfterCreate - bucketsLengthBeforeCreate).toBe 1

    $httpBackend.flush()

  it 'can update a bucket', inject (_buckets_) ->
    $httpBackend.expectGET('bucket_groups/1/buckets')
      .respond 200, bucketsResponse
    buckets = _buckets_.query
      bucket_group_id: 1
    $httpBackend.flush()

    $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200

    bucket = buckets[0]
    bucket.$update()
    $httpBackend.flush()

  it 'can delete a bucket', inject (_buckets_) ->
    $httpBackend.expectGET('bucket_groups/1/buckets')
      .respond 200, bucketsResponse
    buckets = _buckets_.query
      bucket_group_id: 1
    $httpBackend.flush()

    $httpBackend.expectDELETE('bucket_groups/1/buckets/1').respond 200

    bucket = buckets[0]
    bucketsLengthBeforeDestroy = buckets.length
    _buckets_.destroy(bucket)
    bucketsLengthAfterDestroy = buckets.length
    expect(bucketsLengthBeforeDestroy - bucketsLengthAfterDestroy).toBe 1
    $httpBackend.flush()

  describe '.bucketsUpTo', ->
    it 'returns all buckets, sorted from last to first, up to the given index', inject (_buckets_) ->
      $httpBackend.expectGET('bucket_groups/1/buckets')
        .respond 200, bucketsResponse
      buckets = _buckets_.query
        bucket_group_id: 1
      $httpBackend.flush()

      expect(_buckets_.bucketsUpTo(2)).toEqual(buckets.slice(0, 2).reverse())

  describe '.bucketsAfter', ->
    it 'returns all buckets after the given index', inject (_buckets_) ->
      $httpBackend.expectGET('bucket_groups/1/buckets')
        .respond 200, bucketsResponse
      buckets = _buckets_.query
        bucket_group_id: 1
      $httpBackend.flush()

      expect(_buckets_.bucketsAfter(1)).toEqual(buckets.slice(2, 3))

  describe '.incrementPosition', ->
    it 'increases the position of the given index in the array by 1', inject (_buckets_) ->
      $httpBackend.expectGET('bucket_groups/1/buckets')
        .respond 200, bucketsResponse
      buckets = _buckets_.query
        bucket_group_id: 1
      $httpBackend.flush()
      bucket = buckets[0]

      $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200

      indexBeforeIncrementingPosition = buckets.indexOf(bucket)
      _buckets_.incrementPosition(bucket)
      $httpBackend.flush()
      indexAfterIncrementingPosition = buckets.indexOf(bucket)

      expect(indexAfterIncrementingPosition - indexBeforeIncrementingPosition).toEqual(1)

  describe '.decrementPosition', ->
    it 'decreases the position of the given index in the array by 1', inject (_buckets_) ->
      $httpBackend.expectGET('bucket_groups/1/buckets')
        .respond 200, bucketsResponse
      buckets = _buckets_.query
        bucket_group_id: 1
      $httpBackend.flush()
      bucket = buckets[1]

      $httpBackend.expectPUT('bucket_groups/1/buckets/2').respond 200

      indexBeforeDecrementingPosition = buckets.indexOf(bucket)
      _buckets_.decrementPosition(bucket)
      $httpBackend.flush()
      indexAfterDecrementingPosition = buckets.indexOf(bucket)

      expect(indexBeforeDecrementingPosition - indexAfterDecrementingPosition).toEqual(1)
