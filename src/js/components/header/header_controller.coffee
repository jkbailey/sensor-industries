@Dashboard.module "Components.Header", (Header, App, Backbone, Marionette, $, _) ->

  class Header.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}
      @headerLayout = new Header.Layout()

      @listenTo @headerLayout, 'show', =>
        @setUserBox()

      @listenTo App.vent, 'global:error', (message) =>
        @headerLayout.showError message

      @region.show @headerLayout

    onNavigate: (route) ->
      @setUserBox()
      @setSelectedRoute route

    setUserBox: ->
      if App.selectedComplex and App.selectedComplex.get('name')
        @headerLayout.updateUserBoxText App.selectedComplex.get('name')
      else if App.company?.isSetUp() and App.company.get('name')
        @headerLayout.updateUserBoxText App.company.get('name')
      else if App.company?.isSetUp()
        @headerLayout.updateUserBoxText '0123456789'


    setSelectedRoute: (route) ->
      switch route
        when 'complex-profile'
          @headerLayout.updateNav 'profile'
        when 'units'
          @headerLayout.updateNav 'units'
        when 'alerts'
          @headerLayout.updateNav 'alerts'
        else
          @headerLayout.hideNav()

  App.reqres.setHandler "header", (options = {})->
    new Header.Controller options
