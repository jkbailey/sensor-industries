@Dashboard = do (Backbone, Marionette, $) ->

  # this is the application - will be referenced repeatedly
  App = new Marionette.Application

  App.on 'before:start', ->
    App.user = App.request 'entities:user'
    App.company = App.request 'entities:company'

  App.on 'start', ->
    App.rootView = App.request 'root:view'
    App.router = App.request 'root:router',
      controller: App.request 'root:controller'

    Backbone.history.start()

  # return the App
  App
