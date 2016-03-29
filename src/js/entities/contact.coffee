@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Contact extends Backbone.Model
    methodToURL:
      'read':   -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}"
      'create': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/"
      'update': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}/update"
      'delete': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}/delete"

    sync: (method, model, options) ->
      options = options || {}
      options.url = model.methodToURL[method.toLowerCase()].call @
      Backbone.sync method, model, options

    validation:
      fullName:
        required: true
      emailAddress:
        pattern: 'email'
      title:
        required: true
      phone:
        minLength: 10

  class Entities.Contacts extends Backbone.Collection
    model: Entities.Contact
    comparator: 'id'


  App.reqres.setHandler 'entities:contact', (attrs = {}) ->
    new Entities.Contact attrs

  App.reqres.setHandler 'entities:contacts', (attrs = []) ->
    new Entities.Contacts attrs
