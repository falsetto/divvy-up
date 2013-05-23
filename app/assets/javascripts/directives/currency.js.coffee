angular.module('divvyUp')
  .directive('duCurrency', ['$filter', ($filter) ->
    restrict: 'A',
    require: 'ngModel',
    link: (scope, element, attr, ctrl) ->
      parseFormattedNumberAsFloat = (amount) ->
        return 0 unless amount
        parseFloat amount.replace(/[^0-9.]/g, '')
      ctrl.$parsers.push(parseFormattedNumberAsFloat)

      formatNumberAsCurrency = (amount) ->
        $filter('currency')(amount, '')
      ctrl.$formatters.push(formatNumberAsCurrency)
  ])
