@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}

      @companyProfileLayout = new CompanyProfile.Layout
        model: App.company
        collection: App.company.get 'contacts'

      @listenTo @companyProfileLayout, 'add:contact', =>
        App.company.get('contacts').add {}

      @listenTo @companyProfileLayout, 'childview:submit', (x,y,z) ->
        console.log x, y, z

      @listenTo @companyProfileLayout, 'submit', =>
        data = @companyProfileLayout.serialize()
        @saveContacts()
        @saveCompany()

      @listenTo @companyProfileLayout, 'destroy', =>
        @destroy()

      @region.show @companyProfileLayout

    saveContacts: ->
      @companyProfileLayout.children.each (view) ->
        view.model.save view.serialize(),
          success: ->
            console.log 'saved'
          error: ->
            console.log 'error'
        console.log view.serialize()

    saveCompany: ->
      App.company.save @companyProfileLayout.serialize(),
        success: =>
          console.log App.company
          # @trigger 'company:profile:success'


  App.reqres.setHandler "company:profile", (options = {}) ->
    new CompanyProfile.Controller options
