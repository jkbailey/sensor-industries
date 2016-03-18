@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}

      @companyProfileLayout = new CompanyProfile.Layout
        model: App.company
        collection: App.company.contacts

      @listenTo @companyProfileLayout, 'add:contact', ->
        App.company.contacts.add
          company: App.company.id
          complex: 0
          primary: true

      @listenTo @companyProfileLayout, 'submit', =>
        @saveContacts()
        @saveCompany()

      @listenTo @companyProfileLayout, 'destroy', =>
        @destroy()

      @region.show @companyProfileLayout

    saveContacts: ->
      @companyProfileLayout.children.each (view) ->
        view.model.save view.serialize(),
          success: ->
            console.log 'Saved company\'s contact data.'
          error: ->
            alert 'There was an error saving one of the company\'s contact.'
        console.log view.serialize()

    saveCompany: ->
      App.company.save @companyProfileLayout.serialize(),
        success: =>
          console.log 'Saved company data.'
          @trigger 'company:profile:success'
        error: ->
          alert 'There was an error saving the company data.'


  App.reqres.setHandler "company:profile", (options = {}) ->
    new CompanyProfile.Controller options
