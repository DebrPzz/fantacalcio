app.controller('AppController', function() {
    var vm = this;
    vm.nav = [
       {
        url:"#/",
        title:"Home"
       },{
        url:"#/calciatori",
        title:"Calciatori"
       },{
        url:"#/squadre",
        title:"Squadre"
       },{
        url:"#/calendario",
        title:"Calendario"
       }
    ];
});
