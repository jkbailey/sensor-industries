@Dashboard.module "Components.ComplexProfile", (ComplexProfile, App, Backbone, Marionette, $, _) ->

  class ComplexProfile.Layout extends Marionette.LayoutView
    template: JST['components/complex_profile/templates/profile']

    triggers:
      'click .btn.primary': 'submit'

    onRender: ->
      @addStateDropdowns '.complex-legal-state', 'legal-state'
      @addStateDropdowns '.complex-physical-state', 'state'
      @addStateDropdowns '.contact-state', 'contact[state]'

    @include "StateDropdown", "Serialize"
