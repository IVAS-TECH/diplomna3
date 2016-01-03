module.exports = (registerService, loginService, authenticationService, $scope, $window, transitionService) ->
  controller = @
  controller.$inject = ["registerService", "loginService", "authenticationService", "$scope", "$window", "transitionService"]

  authenticateUser = ->
    controller.user = authenticationService.getUser()
    controller.authenticated = authenticationService.isAuthenticated()
    if authenticationService.isAsync() then $scope.$digest()

  init = ->

    $scope.$on "authentication", ->
      authenticateUser()

      if not authenticationService.isSession()
        $window.onbeforeunload = (event) ->
          event.preventDefault()
          authenticationService.unauthenticate ->
          return

  controller.register = (event) -> registerService event

  controller.login = (event) -> loginService event

  controller.logout = (event) ->
    authenticationService.unauthenticate ->
      authenticateUser()
      transitionService.toHome()

  init()

  controller
