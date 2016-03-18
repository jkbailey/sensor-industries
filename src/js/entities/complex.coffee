@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Complex extends Backbone.Model
    methodToURL:
      'read':   -> "http://dev.waterr8.com:8080/api/v1/customer/complex/#{@id}"
      'create': -> "http://dev.waterr8.com:8080/api/v1/customer/complex/"
      'update': -> "http://dev.waterr8.com:8080/api/v1/customer/complex/#{@id}/update"
      'delete': -> "http://dev.waterr8.com:8080/api/v1/customer/complex/#{@id}/delete"

    sync: (method, model, options) ->
      options = options || {}
      options.url = model.methodToURL[method.toLowerCase()].call @
      Backbone.sync method, model, options

    blacklist: ['units',]
    toJSON: (options) -> _.omit @attributes, @blacklist

    initialize: ->
      @contacts = App.request 'entities:contacts', App.company.contacts.where
        complex: @id

      console.log @

    isSetUp: ->
      @get('phone')? and String(@get('phone')).length > 0
      false

  class Entities.Complexes extends Backbone.Collection
    model: Entities.Complex
    url: -> "http://dev.waterr8.com:8080/api/v1/customer/company/#{App.company.id}/complexes"

  App.reqres.setHandler 'entities:complexes', (options) ->
    new Entities.Complexes [], options
