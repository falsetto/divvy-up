angular.module('divvyUp')
  .factory 'divvyer', ['buckets', (bucketsService) ->
      totalAfterDivvying = (amount, buckets, index) ->
        totalLessPreviousBuckets(amount, index) - divvyAmount(amount, buckets[index])

      divvyAmount = (amount, bucket) ->
        amount * bucket.percentage

      totalLessPreviousBuckets = (amount, index) ->
        amount - _.reduce bucketsService.bucketsUpTo(index), (total, bucket) ->
          total + divvyAmount(amount, bucket)
        , 0

      totalAfterDivvying: totalAfterDivvying
      divvyAmount: divvyAmount
  ]
