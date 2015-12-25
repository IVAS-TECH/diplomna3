{angular} = require "dependencies"
moduleName = "configurationModule"

angular
  .module moduleName, []
    .service "progressService", require "./progressService"
    .factory "scopeControllerService", require "./scopeControllerService"
    .controller "configurationInterface", require "./configurationInterface"
    .controller "configurationController", require "./configurationController"
    .directive "ivoConfigInfo", require "./configurationInfo/configurationInfoDirective"
    .directive "ivoInclude", require "./includeDirective"
    .directive "ivoStencilPreview", require "./stencilPreview/stencilPreviewDirective"

module.exports = moduleName
