@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Company extends Backbone.Model

    blacklist: ['complexes','contacts',]
    toJSON: (options) -> _.omit @attributes, @blacklist

    # parse: (response, options) ->
    #   console.log response
    #   {}


    # localStorage: new Backbone.LocalStorage "Company"
    urlRoot: "http://dev.waterr8.com:8080/api/v1/customer/company"

    isSetUp: ->
      @get('phone')? and String(@get('phone')).length > 0
      false

    selectComplex: (id) ->
      complexes = @get('complexes')

      if id?
        App.selectedComplex = complexes.get(id)
      else if complexes.length is 1
        App.selectedComplex = complexes.at(0)


  App.reqres.setHandler 'entities:company', (attrs = {}) ->
    new Entities.Company attrs
