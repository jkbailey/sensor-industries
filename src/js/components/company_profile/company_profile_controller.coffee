@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}
      @companyProfileLayout = new CompanyProfile.Layout
        model: App.company

      @listenTo @companyProfileLayout, 'submit', =>
        data = @companyProfileLayout.serialize()
        App.company.save @companyProfileLayout.serialize(),
          success: =>
            @trigger 'company:profile:success'

      @listenTo @companyProfileLayout, 'destroy', =>
        @destroy()

      @region.show @companyProfileLayout

  App.reqres.setHandler "company:profile", (options = {}) ->
    new CompanyProfile.Controller options
