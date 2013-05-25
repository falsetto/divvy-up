describe 'buckets Service', ->
  $httpBackend = null
  buckets = null
  bucketsResponse = null

  beforeEach module 'divvyUp', 'mockedBuckets'

  beforeEach inject (_$httpBackend_, _buckets_, defaultJSON) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('bucket_groups/1/buckets')
      .respond 200, defaultJSON
    buckets = _buckets_.query
      id: 1
      amount: 1000
    $httpBackend.flush()

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'can create a new bucket', inject (_buckets_) ->
    $httpBackend.expectPOST('bucket_groups/1/buckets').respond 200

    bucketsLengthBeforeCreate = buckets.length
    _buckets_.create
      id: 1
      amount: 1000
    bucketsLengthAfterCreate = buckets.length
    expect(bucketsLengthAfterCreate - bucketsLengthBeforeCreate).toBe 1
    bucket = buckets[buckets.length - 1]
    expect(bucket.amount()).toBe('0.00')
    expect(bucket.leftover()).toBe('670.00')

    $httpBackend.flush()

  it 'can update a bucket', ->
    $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200

    bucket = buckets[0]
    bucket.$update()
    $httpBackend.flush()

  it 'can delete a bucket', inject (_buckets_) ->
    $httpBackend.expectDELETE('bucket_groups/1/buckets/1').respond 200

    bucket = buckets[0]
    bucketsLengthBeforeDestroy = buckets.length
    _buckets_.destroy(bucket)
    bucketsLengthAfterDestroy = buckets.length
    expect(bucketsLengthBeforeDestroy - bucketsLengthAfterDestroy).toBe 1
    $httpBackend.flush()

  describe '#amount', ->
    it "returns bucket's portion of its bucket group's amount", ->
      expect(buckets[0].amount()).toBe '100.00'
      expect(buckets[1].amount()).toBe '80.00'
      expect(buckets[2].amount()).toBe '150.00'

  describe '#leftover', ->
    it "returns the amount remaining in the bucketGroup after removing this bucket's portion", ->
      expect(buckets[0].leftover()).toBe '900.00'
      expect(buckets[1].leftover()).toBe '820.00'
      expect(buckets[2].leftover()).toBe '670.00'

  describe '::bucketsUpTo', ->
    it 'returns all buckets, sorted from last to first, up to the given index', inject (_buckets_) ->
      expect(_buckets_.bucketsUpTo(2)).toEqual(buckets.slice(0, 2).reverse())

  describe '::bucketsAfter', ->
    it 'returns all buckets after the given index', inject (_buckets_) ->
      expect(_buckets_.bucketsAfter(1)).toEqual(buckets.slice(2, 3))

  describe '::incrementPosition', ->
    it 'increases the position of the given index in the array by 1', inject (_buckets_) ->
      bucket = buckets[0]

      $httpBackend.expectPUT('bucket_groups/1/buckets/1').respond 200

      indexBeforeIncrementingPosition = buckets.indexOf(bucket)
      _buckets_.incrementPosition(bucket)
      $httpBackend.flush()
      indexAfterIncrementingPosition = buckets.indexOf(bucket)

      expect(indexAfterIncrementingPosition - indexBeforeIncrementingPosition).toEqual(1)

  describe '::decrementPosition', ->
    it 'decreases the position of the given index in the array by 1', inject (_buckets_) ->
      bucket = buckets[1]

      $httpBackend.expectPUT('bucket_groups/1/buckets/2').respond 200

      indexBeforeDecrementingPosition = buckets.indexOf(bucket)
      _buckets_.decrementPosition(bucket)
      $httpBackend.flush()
      indexAfterDecrementingPosition = buckets.indexOf(bucket)

      expect(indexBeforeDecrementingPosition - indexAfterDecrementingPosition).toEqual(1)
