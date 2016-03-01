@Dashboard.module "Components.Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Layout extends Marionette.LayoutView
    template: JST['components/login/templates/form']
    id: 'login'
    className: 'align-middle'

    ui:
      loginError: '.login-error'

    triggers:
      'click .primary': 'submit'

    onRender: ->
      @hideLoginError()

    showLoginError: ->
      @ui.loginError.show()

    hideLoginError: ->
      @ui.loginError.hide()

    @include 'Serialize'
