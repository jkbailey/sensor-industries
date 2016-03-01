@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Unit extends Backbone.Model

    defaults:
      id: 1
      complex_id: 1

    blacklist: ['sensors',]

    toJSON: (options) -> _.omit @attributes, @blacklist

    # localStorage: new Backbone.LocalStorage "Complex"
    # url: 'http://sensor.dev/complex'

    initialize: ->
      console.log 'init unit'
      # @fetch()
      # @set 'units', App.request 'entities:units'

    isSetUp: ->
      @get('gateway')? and String(@get('gateway')).length > 0

  class Entities.Units extends Backbone.Collection
    model: Entities.Unit
    localStorage: new Backbone.LocalStorage "Units"
    # url: 'http://sensor.dev/complexes'

  App.reqres.setHandler 'entities:units', (options) ->
    new Entities.Units [], options
