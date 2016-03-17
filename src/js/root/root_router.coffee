@Dashboard.module "Root", (Root, App, Backbone, Marionette, $, _) ->

  class Root.Router extends Marionette.AppRouter
    appRoutes:
      '': 'index'
      'sign-in': 'index'
      'company-profile': 'companyProfile'
      'complex-profile': 'complexProfile'
      'complexes': 'listComplexes'
      'units': 'listUnits'
      'alerts': 'alerts'

    before:
      '*any': (route) ->
        @options.controller.onBeforeRoute route

    after:
      '*any': (route) ->
        @options.controller.onAfterRoute route

  App.reqres.setHandler "root:router", (options) ->
    new Root.Router
      controller: options.controller
