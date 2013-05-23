angular.module('divvyUp')
  .directive('duPercentage', ->
    restrict: 'A',
    require: 'ngModel',
    link: (scope, element, attr, ngModelCtrl) ->
      convertPercentageToFloat = (percentage) ->
        (parseFloat(percentage) || 0) / 100
      ngModelCtrl.$parsers.push(convertPercentageToFloat)

      convertFloatToPercentage = (float) ->
        Math.round(float * 100 * 10) / 10
      ngModelCtrl.$formatters.push(convertFloatToPercentage)
  )
