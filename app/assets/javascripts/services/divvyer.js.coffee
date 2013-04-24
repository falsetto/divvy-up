angular.module('divvyUp')
  .factory 'divvyer', ['buckets', (buckets) ->
      totalAfterDivvying = (amount, bucket) ->
        totalLessPreviousBuckets(amount, bucket.priority) - divvyAmount(amount, bucket)

      divvyAmount = (amount, bucket) ->
        amount * bucket.percentage

      totalLessPreviousBuckets = (amount, priorityIndex) ->
        amount - _.reduce buckets.bucketsUpTo(priorityIndex), (total, bucket) ->
          total + divvyAmount(amount, bucket) if bucket.priority < priorityIndex
        , 0

      totalAfterDivvying: totalAfterDivvying
      divvyAmount: divvyAmount
  ]
