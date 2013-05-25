angular.module('divvyUp')
  .controller('MainCtrl',
    ($http, $scope, $window, bucketGroups, buckets, serverSyncer) ->
      $http.defaults.headers.common.Accept = 'application/json'
      $scope.bucketsService = buckets

      $scope.bucketGroups = bucketGroups.query (bucketGroups) ->
        $scope.bucketGroup = bucketGroups[0]

      $scope.$watch 'bucketGroup.id', (newValue, oldValue) ->
        if newValue
          $scope.buckets = buckets.query $scope.bucketGroup

      $scope.queueSync = (form, object) ->
        serverSyncer.queueSync(object) if form.$valid

      $scope.destroyBucket = (bucket) ->
        if $window.confirm 'Are you sure?'
          buckets.destroy(bucket)
  )
