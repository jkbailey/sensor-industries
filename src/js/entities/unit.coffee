@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Unit extends Backbone.Model
    methodToURL:
      'read':   -> "http://dev.waterr8.com:8080/api/v1/customer/unit/#{@id}"
      'create': -> "http://dev.waterr8.com:8080/api/v1/customer/unit/"
      'update': -> "http://dev.waterr8.com:8080/api/v1/customer/unit/#{@id}/update"
      'delete': -> "http://dev.waterr8.com:8080/api/v1/customer/unit/#{@id}/delete"

    sync: (method, model, options) ->
      options = options || {}
      options.url = model.methodToURL[method.toLowerCase()].call @
      Backbone.sync method, model, options

    blacklist: ['sensors',]
    toJSON: (options) -> _.omit @attributes, @blacklist

    initialize: ->
      console.log 'init unit'

    isSetUp: ->
      @get('gateway')? and String(@get('gateway')).length > 0

  class Entities.Units extends Backbone.Collection
    model: Entities.Unit
    url: -> "http://dev.waterr8.com:8080/api/v1/customer/complex/#{App.selectedComplex.id}/units"

  App.reqres.setHandler 'entities:units', (units) ->
    new Entities.Units units
