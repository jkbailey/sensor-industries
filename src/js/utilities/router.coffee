@Dashboard.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  class App.Router extends Marionette.AppRouter

    route: (route, name, callback) ->

      if !callback then callback = @[name]

      _routeFunction = =>
        controller = @_getController()
        controller.triggerMethod 'before:route', route
        callback.apply @, arguments
        controller.triggerMethod 'after:route', route

      Backbone.Router.prototype.route.call @, route, name, _routeFunction
