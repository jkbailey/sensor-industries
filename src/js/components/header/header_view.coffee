@Dashboard.module "Components.Header", (Header, App, Backbone, Marionette, $, _) ->

  class Header.Layout extends Marionette.LayoutView
    template: JST['components/header/templates/header']

    ui:
      nav: '.complex-nav'
      userBox: '.user'
      userBoxText: '.user .name span'
      errorBox: '.global-error'

    updateUserBoxText: (text) ->
      @ui.userBoxText.text text

    updateNav: (nav_item) ->
      @$('.current').removeClass 'current'
      @$(".#{nav_item}").addClass 'current'
      if App.selectedComplex?.isSetUp()
        @showNav()

    showNav: ->
      @ui.nav.show()

    hideNav: ->
      @ui.nav.hide()

    showError: (message) ->
      @ui.errorBox.text message
