@Dashboard.module "Root", (Root, App, Backbone, Marionette, $, _) ->

  class Root.Controller extends Marionette.Controller

    onBeforeRoute: (route) ->
      if route isnt ''
        unless App.user.isLoggedIn()
          App.router.navigate '',
            trigger: true
          return false

    onAfterRoute: (route) ->
      @setHeader route

    determineLandingScreen: ->
      if App.company.isSetUp()
        if App.company.get('complexes').length < 2
          App.company.selectComplex()

        if not App.selectedComplex
          return 'complexes'
        else if App.selectedComplex.isSetUp()
          return 'units'
      else
        return 'company-profile'


    index: ->
      console.log 'index'
      if App.user.isLoggedIn()
        App.router.navigate @determineLandingScreen()
      else
        @login = App.request 'login:form',
          region: App.rootView.overlay

        @listenTo @login, 'login:success', =>
          App.router.navigate 'company-profile',
            trigger: true
          @login.region.empty()

    companyProfile: ->
      console.log 'company Profile'
      @companyProfile = App.request 'company:profile',
        region: App.rootView.body

      @listenTo @companyProfile, 'company:profile:success', =>
        @companyProfile.region.empty()
        App.router.navigate 'complex-profile',
          trigger: true

    complexProfile: ->
      if App.company.get('complexes').length < 2
        App.company.selectComplex()

      if not App.selectedComplex
        App.router.navigate 'complexes'
      else
        @complexProfile = App.request 'complex:profile',
          region: App.rootView.body

        @listenTo @complexProfile, 'complex:profile:success', =>
          @complexProfile.region.empty()
          App.router.navigate 'units',
            trigger: true

    listComplexes: ->
      console.log 'listComplexes'

    listUnits: ->
      console.log 'listUnits'
      @unitList = App.request 'unit:list',
        region: App.rootView.body

    alerts: ->
      console.log 'alerts'


    setHeader: (route) ->
      unless @header?
        @header = App.request 'header',
          region: App.rootView.header
        @header.triggerMethod 'navigate', route
      else
        @header.triggerMethod 'navigate', route




  App.reqres.setHandler "root:view", ->
    view = new Root.Layout()
    view.render()
    view

  App.reqres.setHandler "root:controller", ->
    new Root.Controller()
