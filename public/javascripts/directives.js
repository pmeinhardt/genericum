(function() {
  var module = angular.module('app.directives', []);

  module.directive('loadingIndicator', function() {
    return {
      restrict: 'EAC',
      templateUrl: '/loading-indicator'
    };
  });
})();
