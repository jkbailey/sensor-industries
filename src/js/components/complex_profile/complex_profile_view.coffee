@Dashboard.module "Components.ComplexProfile", (ComplexProfile, App, Backbone, Marionette, $, _) ->

  class ComplexProfile.Contact extends Marionette.ItemView
    template: JST['components/complex_profile/templates/contact']
    tagName: 'li'

    @include 'Serialize'

  class ComplexProfile.Layout extends Marionette.CompositeView
    template: JST['components/complex_profile/templates/profile']
    childView: ComplexProfile.Contact
    childViewContainer: '.contacts-list'
    formContainer: '.complex-form'

    triggers:
      'click .btn.primary': 'submit'
      'click .add-contact': 'add:contact'

    onRender: ->
      @addStateDropdowns '.complex-legal-state', 'legal-state'
      @addStateDropdowns '.complex-physical-state', 'state'

    @include "StateDropdown", "Serialize"
