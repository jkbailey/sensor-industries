@Dashboard.module "Root", (Root, App, Backbone, Marionette, $, _) ->

  class Root.Router extends App.Router
    appRoutes:
      '': 'index'
      'sign-in': 'index'
      'company-profile': 'companyProfile'
      'complex-profile': 'complexProfile'
      'complexes': 'listComplexes'
      'units': 'listUnits'
      'alerts': 'alerts'

  App.reqres.setHandler "root:router", (options) ->
    new Root.Router
      controller: options.controller
