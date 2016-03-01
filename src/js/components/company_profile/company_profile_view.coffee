@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Layout extends Marionette.LayoutView
    template: JST['components/company_profile/templates/profile']

    triggers:
      'click .btn.primary': 'submit'

    onRender: ->
      @addStateDropdowns '.company-state', 'state'
      @addStateDropdowns '.contact-state', 'contact[state]'
      @deserialize()

    @include 'StateDropdown', 'Serialize'
