@Dashboard.module "Components.ComplexProfile", (ComplexProfile, App, Backbone, Marionette, $, _) ->

  class ComplexProfile.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}

      @complexProfileLayout = new ComplexProfile.Layout
        model: App.selectedComplex
        collection: App.selectedComplex.contacts

      @listenTo @complexProfileLayout, 'add:contact', ->
        App.selectedComplex.contacts.add
          company: App.company.id
          complex: App.selectedComplex.id

      @listenTo @complexProfileLayout, 'submit', =>
        @saveContacts()
        @saveComplex()

      @listenTo @complexProfileLayout, 'destroy', =>
        @destroy()

      @region.show @complexProfileLayout

    saveContacts: ->
      @complexProfileLayout.children.each (view) ->
        view.model.save view.serialize(),
          success: ->
            console.log 'Saved complex\'s contact data.'
          error: ->
            alert 'There was an error saving one of the complex\'s contact.'
        console.log view.serialize()

    saveComplex: ->
      App.selectedComplex.save @complexProfileLayout.serialize(),
        success: =>
          console.log 'Saved complex data.'
          @trigger 'complex:profile:success'
        error: ->
          alert 'There was an error saving the complex data.'

  App.reqres.setHandler "complex:profile", (options = {}) ->
    new ComplexProfile.Controller options
