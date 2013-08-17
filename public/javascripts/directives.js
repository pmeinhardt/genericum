var module = angular.module('app.directives', []);

module.directive('loadingIndicator', function() {
  return {
    restrict: 'EAC',
    template: [
      '<div class="progress progress-striped active" ng-show="loading">',
      '  <div class="progress-bar" role="progressbar" aria-valuenow="100" ',
        'aria-valuemin="0" aria-valuemax="100" style="width: 100%">',
      '    <span class="sr-only">Loading</span>',
      '  </div>',
      '</div>',
    ].join('')
  };
});
