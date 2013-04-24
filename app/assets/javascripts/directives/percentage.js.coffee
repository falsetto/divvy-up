angular.module('divvyUp')
  .directive('duPercentage', ->
    restrict: 'A',
    require: 'ngModel',
    link: (scope, element, attr, ngModelCtrl) ->
      fromUser = (text) ->
        (parseFloat(text) || 0) / 100

      toUser = (text) ->
        text * 100

      ngModelCtrl.$parsers.push(fromUser)
      ngModelCtrl.$formatters.push(toUser)

  )
