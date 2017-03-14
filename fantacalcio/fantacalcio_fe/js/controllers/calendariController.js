app.controller('calendariController', [ '$routeParams', '$location', '$scope', 'calendariService',
    function($routeParams, $location, $scope, calendariService) {
    var vm = $scope;
    
    vm.id = null;
    vm.item = {};
    vm.items = [];
    
    vm.loadItem = function(response){
        vm.item = response.data && response.data.item;
        vm.message = response.data && response.data.message || "";
    };
    
    vm.resetItem = function(){
        return {
            id:0,
            nome:'',
            telefono:'',
            cf:'',
            datanascita: null,
            sesso: ''
        };
    };
    
    vm.loadItems = function(response){
        var list = response.data && response.data.items || [];
        vm.items.length = 0;
        angular.forEach(list, function(v,k){
            vm.items.push(v);
        });
        vm.message = response.data && response.data.message || "";
    };

    vm.save = function(){
        calendariService.saveItem(vm.item,vm.loadItems);
    };
    
    vm.view = function(id){
        $location.path( '/calendario/'+id );
    };
    
    vm.back = function(){
        $location.path( '/calendario' );
    };
    
    vm.del = function(id){
        calendariService.delItem(id,vm.loadItems);
    };
    
    vm.init = function(){
        vm.id = $routeParams && $routeParams['id'] || false;
        if(vm.id){
            calendariService.getItem(vm.id,vm.loadItem);
        }else{
            calendariService.getList(vm.loadItems);
        }
    };
    
    vm.init();
}]);