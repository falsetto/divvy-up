angular.module('divvyUp')
  .directive('duCurrency', ['$filter', ($filter) ->
    restrict: 'A',
    require: 'ngModel',
    link: (scope, element, attr, ngModelCtrl) ->
      fromUser = (amount) ->
        return 0 unless amount
        parseFloat amount.replace(/[^0-9.]/g, '')

      toUser = (amount) ->
        $filter('currency')(amount, '')

      ngModelCtrl.$parsers.push(fromUser)
      ngModelCtrl.$formatters.push(toUser)

  ])
