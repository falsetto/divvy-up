angular.module('divvyUp')
  .factory 'buckets', ($filter, $http, $resource, $rootScope) ->
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

      bucketsUpTo = (index) ->
        buckets.slice(0, index).reverse()

      totalAfterDivvying = (amount, buckets, index) ->
        totalLessPreviousBuckets(amount, index) -
          divvyAmount(amount, buckets[index])

      divvyAmount = (amount, bucket) ->
        amount * bucket.percentage

      totalLessPreviousBuckets = (amount, index) ->
        amount - _.reduce bucketsUpTo(index), (total, bucket) ->
          total + divvyAmount(amount, bucket)
        , 0

      attachInstanceMethods = (bucketGroup, bucket) ->
        bucket.amount = ->
          $filter('currency')(
            bucket.percentage * bucketGroup.amount
            , '')

        bucket.leftover = ->
          $filter('currency')(
            totalAfterDivvying(bucketGroup.amount,
                               buckets,
                               buckets.indexOf(bucket))
            , '')

      query: (bucketGroup) ->
        buckets = Bucket.query bucket_group_id: bucketGroup.id, ->
          buckets.forEach (bucket) ->
            attachInstanceMethods(bucketGroup, bucket)

      create: (bucketGroup) ->
        bucket = new Bucket
          bucket_group_id: bucketGroup.id
          name: 'New bucket'
          percentage: 0
        buckets.push bucket
        attachInstanceMethods(bucketGroup, bucket)
        bucket.$save (_bucket) ->
          attachInstanceMethods(bucketGroup, _bucket)
      destroy: (bucket) ->
        buckets.splice buckets.indexOf(bucket), 1
        bucket.$delete()

      bucketsUpTo: bucketsUpTo
      bucketsAfter: (index) ->
        buckets.slice(index + 1, buckets.length)
      incrementPosition: (bucket) ->
        shiftPosition(bucket, 1)
      decrementPosition: (bucket) ->
        shiftPosition(bucket, -1)
