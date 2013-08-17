var module = angular.module('app.controllers', []);

module.controller('SearchController', function($scope, $location) {
  $scope.init = function() {
    $scope.query = $location.search().query;
  };

  $scope.submit = function() {
    if (!$scope.query) {
      $location.url('/');
      return;
    }

    $location.path('/search').search({ query: $scope.query });
  };

  $scope.init();
});

module.controller('ResultsController', function($scope, $http, $location) {
  $scope.init = function() {
    $scope.loading = false;
    $scope.substances = [];
    $scope.drugs = [];
  };

  $scope.load = function() {
    var config = { params: { query: $location.search().query } };
    var request = $http.get('/search.json', config);

    $scope.loading = true;

    request.success(function(data) {
      $scope.loading = false;
      $scope.substances = data.substances;
      $scope.drugs = data.drugs;
    });

    request.error(function(response) {
      $scope.loading = false;
    });
  };

  $scope.init();
  $scope.load();
});

module.controller('DrugController', function($scope, $http, $routeParams) {
  $scope.init = function() {
    $scope.loading = false;
    $scope.drug = {};
  };

  $scope.load = function() {
    var id = $routeParams.id;
    var request = $http.get('/drugs/' + id + '.json');

    $scope.loading = true;

    request.success(function(drug) {
      $scope.loading = false;
      $scope.drug = drug;
    });

    request.error(function(response) {});
  };

  $scope.init();
  $scope.load();
});

module.controller('SubstanceController', function($scope, $http, $routeParams) {
  $scope.init = function() {
    $scope.loading = false;
    $scope.substance = {};
  };

  $scope.load = function() {
    var id = $routeParams.id;
    var request = $http.get('/substances/' + id + '.json');

    $scope.loading = true;

    request.success(function(substance) {
      $scope.loading = false;
      $scope.substance = substance;
    });

    request.error(function(response) {});
  };

  $scope.init();
  $scope.load();
});
