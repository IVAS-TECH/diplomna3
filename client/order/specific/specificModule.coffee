{angular} = require "dependencies"
moduleName = "specificModule"
#en = require "./language-en"
#bg = require "./language-bg"

angular
  .module moduleName, []
    .directive "ivoFile", require "./fileDirective"
    .config (translateProvider) ->
      @$inject = ["translateProvider"]
      #translateProvider.add en, bg


module.exports = moduleName
