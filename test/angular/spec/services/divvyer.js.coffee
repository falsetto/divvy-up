describe 'divvyer Service', ->
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

  describe '.divvyAmount', ->
    it "calculates a bucket's percentage of the total amount",
      inject (divvyer) ->
        firstBucket = percentage: 0.1
        expect(divvyer.divvyAmount(1000, firstBucket)).toBe 100
        secondBucket = percentage: 0.15
        expect(divvyer.divvyAmount(1000, secondBucket)).toBe 150

  describe '.totalAfterDivvying', ->
    it 'calculates the amount leftover after divvying previous buckets',
      inject (divvyer, _buckets_) ->
        $httpBackend.whenGET('bucket_groups/1/buckets')
          .respond 200, bucketsResponse
        buckets = _buckets_.query
          bucket_group_id: 1
        $httpBackend.flush()

        expect(divvyer.totalAfterDivvying(1000, buckets, 0)).toBe 900
        expect(divvyer.totalAfterDivvying(1000, buckets, 1)).toBe 750
        expect(divvyer.totalAfterDivvying(1000, buckets, 2)).toBe 700
