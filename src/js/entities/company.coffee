@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Company extends Backbone.Model

    defaults:
      id: 1

    blacklist: ['complexes',]

    toJSON: (options) -> _.omit @attributes, @blacklist

    localStorage: new Backbone.LocalStorage "Company"

    initialize: ->
      @setFetchListener()
      @fetch()

    setFetchListener: ->
      App.execute 'when:fetched', @, =>
        complexes = App.request 'entities:complexes',
          company_id: @get 'id'

        App.execute 'when:fetched', complexes, =>
          if complexes.length is 0
            complexes.create()

        complexes.fetch()
        @set 'complexes', complexes

    isSetUp: ->
      @get('phone')? and String(@get('phone')).length > 0

    selectComplex: (id) ->
      complexes = @get('complexes')

      if id?
        App.selectedComplex = complexes.get(id)
      else if complexes.length is 1
        App.selectedComplex = complexes.at(0)


  App.reqres.setHandler 'entities:company', (attrs) ->
    new Entities.Company attrs
