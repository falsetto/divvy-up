angular.module('divvyUp')
  .controller('MainCtrl', [
    '$http', '$scope','$window', 'bucketGroups', 'buckets', 'divvyer', 'serverSyncer',
    ($http, $scope, $window, bucketGroups, buckets, divvyer, serverSyncer) ->
      $http.defaults.headers.common.Accept = 'application/json'
      $scope.divvyer = divvyer
      $scope.bucketsService = buckets

      $scope.bucketGroups = bucketGroups.query (bucketGroups) ->
        $scope.bucketGroup = bucketGroups[0]

      $scope.$watch 'bucketGroup.id', (newValue, oldValue) ->
        unless newValue == oldValue
          $scope.buckets = buckets.query(bucket_group_id: $scope.bucketGroup.id)

      $scope.queueSync = (form, object) ->
        serverSyncer.queueSync(object) if form.$valid

      $scope.destroyBucket = (bucket) ->
        if $window.confirm 'Are you sure?'
          buckets.destroy(bucket)

  ])
