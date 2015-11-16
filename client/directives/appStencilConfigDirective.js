Directive.$inject = ['Restangular', '$compile'];

function Directive (Restangular, $compile) {
  var directive = {};
  directive.restrict = 'E';
  directive.controller = 'directiveAppStencilConfigController';
  directive.controllerAs = 'vm';
  directive.templateUrl = 'directive-app-stencil-config';
  directive.link = link;
  directive.scope = false;

  function link(scope, element, attributes, controller) {
    var body = element.find('#stencil');
    var text = body.find('span');
    controller.view.text = text;
    controller.view.stencil = stencil;
  }

  return directive;
}

var directiveName = 'appStencilConfig';
var appStencilConfigDirective = {};

appStencilConfigDirective.directiveName = directiveName;
appStencilConfigDirective.directive = Directive;

export var appStencilConfigDirective = appStencilConfigDirective;
