angular.module('divvyUp')
  .factory 'buckets', ['$http', '$resource', ($http, $resource) ->
    bucketData = []

    resource = $resource 'bucket_groups/:bucket_group_id/buckets/:id',
      bucket_group_id: '@bucket_group_id'
      id: '@id'
    , update: method: 'PUT'

    shiftPosition = (bucket, unit) ->
      position = bucketData.indexOf(bucket)
      return if position + unit >= bucketData.length
      return if position + unit < 0
      swappedBucket = bucketData[position + unit]
      bucketData[position] = swappedBucket
      bucketData[position + unit] = bucket
      $http.put "/bucket_groups/#{bucket.bucket_group_id}/buckets/#{bucket.id}",
        bucket: priority_position: position + unit

    query: (callback) ->
      bucketData = resource.query(callback)
    create: (bucketGroup) ->
      bucketInstance = new resource
        bucket_group_id: bucketGroup.id
        name: 'New bucket'
        percentage: 0
      bucketData.push bucketInstance
      bucketInstance.$save()
    destroy: (bucket) ->
      bucketData.splice bucketData.indexOf(bucket), 1
      bucket.$delete()

    bucketsUpTo: (priorityIndex) ->
      _.sortBy(
        _.filter(bucketData, (bucket) -> bucket.priority < priorityIndex)
        , 'priority')
      .reverse()
    bucketsAfter: (priorityIndex) ->
      _.sortBy(
        _.filter(bucketData, (bucket) -> bucket.priority > priorityIndex)
        , 'priority')
    incrementPosition: (bucket) ->
      shiftPosition(bucket, 1)
    decrementPosition: (bucket) ->
      shiftPosition(bucket, -1)
  ]
