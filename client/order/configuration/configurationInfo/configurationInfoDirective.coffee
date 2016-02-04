directive = (template, scopeControllerService) ->

  template: template "configurationInfoView"
  restrict: "E"
  scope:
    controller: "="
    disabled: "="
  link: (scope) ->

    scopeControllerService scope

    stop = scope.$watch "configuration.$valid", (value) ->
      scope.$emit "configuration-validity", value

    scope.$on "$destroy", stop

directive.$inject = ["template", "scopeControllerService"]

module.exports = directive
