@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Contact extends Marionette.ItemView
    template: JST['components/company_profile/templates/contact']
    tagName: 'li'

    @include 'Serialize'

  class CompanyProfile.Layout extends Marionette.CompositeView
    template: JST['components/company_profile/templates/profile']
    childView: CompanyProfile.Contact
    childViewContainer: '.contacts-list'
    formContainer: '.company-form'

    triggers:
      'click .btn.primary': 'submit'
      'click .add-contact': 'add:contact'

    onRender: ->
      @addStateDropdowns '.company-state', 'state'

    @include 'StateDropdown', 'Serialize'
