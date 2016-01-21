module.exports = ($scope, RESTHelperService, $mdDateLocale) ->
  @$inject = ["$scope", "RESTHelperService", "$mdDateLocale"]

  controller = @

  controller.fromDate = controller.toDate = new Date()

  controller.init = ->
    RESTHelperService.order.find (res) ->

      dates = (order) ->
        for type in ["order", "sending"]
          date = type + "Date"
          order[date] = $mdDateLocale.formatDate new Date order[date]
        order

      controller.listOfOrders = (dates order for order in res.orders)

      $scope.$digest()

  controller.panel = "notAdminPanelView"

  controller.labels =
    _id: 40
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  controller.choose = (order) ->
    RESTHelperService.order.view files: order.files, (res) ->
      set = (wich) -> text: order[wich + "Text"], view: res[wich]
      $scope.order = order
      $scope.order.top = set "top"
      $scope.order.bottom = set "bottom"
      $scope.$digest()

  controller.init()

  controller
