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

      @listenTo @companyProfileLayout, 'childview:delete:contact', (view) ->
        if confirm "Are you sure you want to remove #{view.model.get('fullName')} as a point of contact?"
          console.log 'delete contact', view.model
          view.model.destroy()

      @listenTo @companyProfileLayout, 'submit', =>
        if @allValid()
          # Create array of contacts and company xhr objects
          xhrs = @companyProfileLayout.children.map (view) -> view.model.save view.serialize()
          xhrs.push App.company.save @companyProfileLayout.serialize()

          # Confirm all have saved
          $.when(xhrs...).then =>
            @trigger 'company:profile:success'

      @listenTo @companyProfileLayout, 'destroy', =>
        @destroy()

      @region.show @companyProfileLayout

    allValid: ->
      valid = true
      @companyProfileLayout.children.each (view) ->
        if view.preValidate()
          valid = false
      if @companyProfileLayout.preValidate()
        valid = false
      valid



  App.reqres.setHandler "company:profile", (options = {}) ->
    new CompanyProfile.Controller options
