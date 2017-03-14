var app = angular.module('sport', 
    ['ngRoute']);

app.config(function ($routeProvider) { 
  $routeProvider 
    .when('/', { 
      templateUrl: 'views/home.html' 
    })
    .when('/calciatori', { 
      controller: 'AtletiController', 
      templateUrl: 'views/calciatori.html' 
    })
	 .when('/squadre', { 
      controller: 'squadreController', 
      templateUrl: 'views/squadre.html' 
    })
	 .when('/calendario', { 
      controller: 'calendariController', 
      templateUrl: 'views/calendario.html' 
    })
    // .when('/atleti/:id', { 
      // controller: 'AtletiController', 
      // templateUrl: 'views/atleta.html' 
    // }) 
    .otherwise({ 
      redirectTo: '/' 
    }); 
});

app.config(['$httpProvider', function($httpProvider) {
    if (!$httpProvider.defaults.headers.get) {
        $httpProvider.defaults.headers.get = {};    
    }    
    $httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
    $httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
    $httpProvider.defaults.headers.get['Pragma'] = 'no-cache';
}]);

app.constant("settings", {
    "ver": "1.0.0",
    "url": "../fantacalcio_be/",
});

app.filter('unique', function() {
   // we will return a function which will take in a collection
   // and a keyname
   return function(collection, keyname) {
      // we define our output and keys array;
      var output = [], 
          keys = [];
      
      // we utilize angular's foreach function
      // this takes in our original collection and an iterator function
      angular.forEach(collection, function(item) {
          // we check to see whether our object exists
          var key = item[keyname];
          // if it's not already part of our keys array
          if(keys.indexOf(key) === -1) {
              // add it to our keys array
              keys.push(key); 
              // push this item to our final output array
              output.push(item);
          }
      });
      // return our array which should be devoid of
      // any duplicates
      return output;
   };
});

 // app.controller(
        // 'dateController',
        // function ($scope, $filter) {

            // $scope.result = $filter('date')(new Date(), 'fullDate');
        // }
    // );