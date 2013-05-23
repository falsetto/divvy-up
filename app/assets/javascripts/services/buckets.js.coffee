angular.module('divvyUp')
  .factory 'buckets', [
    '$http', '$resource', '$rootScope',
    ($http, $resource, $rootScope) ->
      buckets = []

      Bucket = $resource 'bucket_groups/:bucket_group_id/buckets/:id',
        bucket_group_id: '@bucket_group_id'
        id: '@id'
      , update: method: 'PUT'

      shiftPosition = (bucket, unit) ->
        position = buckets.indexOf(bucket)
        return if position + unit >= buckets.length
        return if position + unit < 0
        swappedBucket = buckets[position + unit]
        buckets[position] = swappedBucket
        buckets[position + unit] = bucket
        $http.put "bucket_groups/#{bucket.bucket_group_id}/buckets/#{bucket.id}",
          bucket: priority_position: position + unit

      query: (callback) ->
        buckets = Bucket.query(callback)
      create: (bucketGroup) ->
        bucket = new Bucket
          bucket_group_id: bucketGroup.id
          name: 'New bucket'
          percentage: 0
        buckets.push bucket
        bucket.$save()
      destroy: (bucket) ->
        buckets.splice buckets.indexOf(bucket), 1
        bucket.$delete()

      bucketsUpTo: (index) ->
        buckets.slice(0, index).reverse()
      bucketsAfter: (index) ->
        buckets.slice(index + 1, buckets.length)
      incrementPosition: (bucket) ->
        shiftPosition(bucket, 1)
      decrementPosition: (bucket) ->
        shiftPosition(bucket, -1)
  ]
