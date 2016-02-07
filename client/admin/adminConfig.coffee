en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, translateProvider, ChartJsProvider) ->

  translateProvider.add en, bg

  $stateProvider.state "home.admin", url: "/admin", templateUrl: "adminView"

  ChartJsProvider.setOptions
    responsive: no
    colours: ["#FF0000", "#0000FF"]

config.$inject = ["$stateProvider", "translateProvider", "ChartJsProvider"]

module.exports = config
