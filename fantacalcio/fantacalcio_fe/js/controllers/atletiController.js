app.controller('AtletiController', [ '$routeParams', '$location', '$scope', 'AtletiService',
    function($routeParams, $location, $scope, AtletiService) {
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

    vm.save = function(item){
        AtletiService.saveItem(item,vm.loadItems);
    };
    
    vm.view = function(id){
        $location.path( '/calciatori/'+id );
    };
    
    vm.back = function(){
        $location.path( '/calciatori' );
    };
    
    vm.del = function(id){
        AtletiService.delItem(id,vm.loadItems);
    };
    
    vm.init = function(){
        vm.id = $routeParams && $routeParams['id'] || false;
        if(vm.id){
            AtletiService.getItem(vm.id,vm.loadItem);
        }else{
            AtletiService.getList(vm.loadItems);
        }
    };
    
    vm.init();
}]);