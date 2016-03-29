@Dashboard.module "Components.CompanyProfile", (CompanyProfile, App, Backbone, Marionette, $, _) ->

  class CompanyProfile.Contact extends Marionette.ItemView
    template: JST['components/company_profile/templates/contact']
    tagName: 'li'

    triggers:
      'click .text-btn.delete': 'delete:contact'

    @include 'Serialize', 'Validation'

  class CompanyProfile.Layout extends Marionette.CompositeView
    template: JST['components/company_profile/templates/profile']
    childView: CompanyProfile.Contact
    childViewContainer: '.contacts-list'
    formContainer: '.company-form'

    triggers:
      'click .btn.primary': 'submit'
      'click .add-contact': 'add:contact'

    modelEvents:
      'invalid': 'modelIsInvalid'

    onRender: ->
      @addStateDropdowns '.company-state', 'state'

    modelIsInvalid: ->
      console.log 'is invalid'

    @include 'StateDropdown', 'Serialize', 'Validation'
