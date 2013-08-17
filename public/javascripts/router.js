(function() {
  var module = angular.module('app.router', []);

  module.config(function($routeProvider) {
    var router = $routeProvider;

    router.when('/', { templateUrl: '/home' });

    router.when('/search', {
      templateUrl: '/results',
      controller: 'ResultsController'
    });

    router.when('/drugs/:id', {
      templateUrl: '/drug',
      controller: 'DrugController'
    });

    router.when('/substances/:id', {
      templateUrl: '/substance',
      controller: 'SubstanceController'
    });

    router.otherwise({ redirectTo: '/' });
  });
})();
