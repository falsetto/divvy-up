describe 'duPercentage', ->
  element = null
  scope = null
  ngModelCtrl = null

  beforeEach module 'divvyUp'

  beforeEach inject ($compile, $rootScope) ->
    element = angular.element '<input ng-model="percentage" du-percentage />'
    scope = $rootScope
    ngModelCtrl = $compile(element)(scope).data('$ngModelController')

  describe 'taking user input', ->
    it 'converts a percentage (e.g. 55) to a float (e.g. 0.55)' , ->
      ngModelCtrl.$setViewValue('55')
      expect(ngModelCtrl.$modelValue).toBe(0.55)
      ngModelCtrl.$setViewValue('100')
      expect(ngModelCtrl.$modelValue).toBe(1.0)

    it 'converts unparseable input to 0', ->
      ngModelCtrl.$setViewValue('fifty-five')
      expect(ngModelCtrl.$modelValue).toBe(0)

  describe 'outputting the model value for rendering in the UI', ->
    it 'converts a float (e.g. 0.55) to a percentage (e.g. 55)' , ->
      scope.percentage = 0.55
      scope.$digest()
      expect(ngModelCtrl.$viewValue).toBe(55)

    it 'keeps one decimal place when converting', ->
      scope.percentage = 0.555
      scope.$digest()
      expect(ngModelCtrl.$viewValue).toBe(55.5)
