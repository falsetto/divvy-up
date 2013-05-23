describe 'duCurrency', ->
  element = null
  scope = null
  ngModelCtrl = null

  beforeEach module 'divvyUp'

  beforeEach inject ($compile, $rootScope) ->
    element = angular.element '<input ng-model="currency" du-currency />'
    scope = $rootScope
    ngModelCtrl = $compile(element)(scope).data('$ngModelController')

  describe 'taking user input', ->
    it 'strips non-digit characters and parses the value into a float' , ->
      ngModelCtrl.$setViewValue('1,000.00')
      expect(ngModelCtrl.$modelValue).toBe(1000)
      ngModelCtrl.$setViewValue('$1,000.00')
      expect(ngModelCtrl.$modelValue).toBe(1000)

  describe 'outputting the model value for rendering in the UI', ->
    it 'formats the value as currency', ->
      scope.currency = 1000
      scope.$digest()
      expect(ngModelCtrl.$viewValue).toBe('1,000.00')
