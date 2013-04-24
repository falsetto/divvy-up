angular.module('divvyUp')
  .factory 'serverSyncer', ['$timeout', ($timeout) ->
    pendingSyncs = {}

    cancelPendingSync = (syncId) ->
      if pendingSync = pendingSyncs[syncId]
        $timeout.cancel(pendingSync)

    queueSync: (object) ->
      syncId = object.$$hashKey
      cancelPendingSync(syncId)
      pendingSyncs[syncId] = $timeout ->
        object.$update()
      , 1250
  ]
