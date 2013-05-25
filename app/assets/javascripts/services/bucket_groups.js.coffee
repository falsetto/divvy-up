angular.module('divvyUp')
  .factory 'bucketGroups', ($resource) ->
    $resource 'bucket_groups/:id',
      id: '@id'
    , update: method: 'PUT'
