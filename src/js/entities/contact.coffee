@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Contact extends Backbone.Model
    url: -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}"

    methodToURL:
      'read':   -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}"
      'create': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}"
      'update': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}/update"
      'delete': -> "http://dev.waterr8.com:8080/api/v1/customer/contact/#{@id}/delete"

    @include "MethodToURL"

  class Entities.Contacts extends Backbone.Collection
    model: Entities.Contact


  App.reqres.setHandler 'entities:contact', (attrs = {}) ->
    new Entities.Contact attrs

  App.reqres.setHandler 'entities:contacts', (attrs = []) ->
    new Entities.Contacts attrs
