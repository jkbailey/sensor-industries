@Dashboard.module "Components.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}

      @loginLayout = new Login.Layout
        model: App.user

      @listenTo @loginLayout, 'submit', =>
        @loginLayout.hideLoginError()
        App.user.set @loginLayout.serialize()
        App.user.validateUser()

      @listenTo App.user, 'user:invalid', =>
        @loginLayout.showLoginError()

      @listenTo App.user, 'user:valid', =>
        @trigger 'login:success'

      @listenTo @loginLayout, 'destroy', =>
        @destroy()

      @region.show @loginLayout

  App.reqres.setHandler "login:form", (options = {})->
    new Login.Controller options
