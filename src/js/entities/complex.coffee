@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Complex extends Backbone.Model

    defaults:
      id: 1
      company_id: 1

    blacklist: ['units',]

    toJSON: (options) -> _.omit @attributes, @blacklist

    # localStorage: new Backbone.LocalStorage "Complex"
    # url: 'http://sensor.dev/complex'

    # initialize: ->
    #   console.log 'init complex'
      # @fetch()
      # @set 'units', App.request 'entities:units'

    isSetUp: ->
      @get('phone')? and String(@get('phone')).length > 0

  class Entities.Complexes extends Backbone.Collection
    model: Entities.Complex
    localStorage: new Backbone.LocalStorage "Complexes"
    # url: 'http://sensor.dev/complexes'

  App.reqres.setHandler 'entities:complexes', (options) ->
    new Entities.Complexes [], options
