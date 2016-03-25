@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Company extends Backbone.Model

    blacklist: ['contacts',]
    toJSON: (options) -> _.omit @attributes, @blacklist
    urlRoot: "http://dev.waterr8.com:8080/api/v1/customer/company"

    initialize: ->
      @on 'validated:invalid', (x) ->
        console.log 'is invalid'

    isSetUp: ->
      @get('phone')? and String(@get('phone')).length > 0
      false

    selectComplex: (id) ->
      if id?
        App.selectedComplex = @complexes.get(id)
      else if @complexes.length is 1
        App.selectedComplex = @complexes.at(0)

    validation:
      companyName:
        required: true
      address:
        required: true
      city:
        required: true
      state:
        required: true
      zip:
        minLength: 5
      phone:
        minLength: 10



  App.reqres.setHandler 'entities:company', (attrs = {}) ->
    new Entities.Company attrs
