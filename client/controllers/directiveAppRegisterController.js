Controller.$inject = ['Restangular', '$rootScope', 'AppShowDialog'];

var controllerName = 'directiveAppRegisterController',
  directiveAppRegisterController = {};

function Controller(Restangular, $rootScope, AppShowDialog) {
    var vm = this,
        restReg = Restangular.all('register');
    vm.register = {};
    vm.register.email;
    vm.register.password;
    vm.repassword;
    vm.reqCheckReg = false;
    vm.exist = exist;
    vm.doRegister = doRegister;

    function doRegister(invalid) {
        vm.registered = vm.failed = false;
        if (!vm.reqCheckReg)
            vm.reqCheckReg = true;
        if (!invalid) {
            var register = {};
            register.user = vm.register;
            restReg.post(register).then(success);
        }
        else
          AppShowDialog('Make sure all fields are valid');

        function success(res) {
            if (!res.error) {
              AppShowDialog('You have beed registered. Please Log In');
              reset();
            } //else

            function reset() {
                var reseted = '';
                vm.reqCheckReg = false;
                vm.register.email = reseted;
                vm.register.password = reseted;
                vm.repassword = reseted;
            }
        }
    }

    function exist(modelValue) {
        var EMAIL_REGEXP = /^[a-z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)*$/i,
          validEmail = false;
        if(!_.isEmpty(modelValue))
          validEmail = EMAIL_REGEXP.test(modelValue);
        if(validEmail) {
          var promise = new Promise(resolver);

          function resolver(resolve, reject) {
              restReg.get(modelValue).then(success);

              function success(res) {
                  if (res.exist)
                      reject();
                  else
                      resolve();
              }
          }

          return promise;
        }
    }
}

directiveAppRegisterController.controllerName = controllerName;
directiveAppRegisterController.controller = Controller;

export var directiveAppRegisterController = directiveAppRegisterController;
