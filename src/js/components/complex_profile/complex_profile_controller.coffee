@Dashboard.module "Components.ComplexProfile", (ComplexProfile, App, Backbone, Marionette, $, _) ->

  class ComplexProfile.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}
      @complexProfileLayout = new ComplexProfile.Layout
        model: App.selectedComplex

      @listenTo @complexProfileLayout, 'submit', =>
        App.selectedComplex.save @complexProfileLayout.serialize(),
          success: =>
            console.log 'saved complex'
            @trigger 'complex:profile:success'

      @listenTo @complexProfileLayout, 'destroy', =>
        @destroy()

      @region.show @complexProfileLayout

  App.reqres.setHandler "complex:profile", (options = {}) ->
    new ComplexProfile.Controller options
