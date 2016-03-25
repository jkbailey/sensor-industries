@Dashboard.module "Components.UnitList", (UnitList, App, Backbone, Marionette, $, _) ->

  class UnitList.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}
      @unitListLayout = new UnitList.Layout
        collection: App.selectedComplex.units

      @listenTo @unitListLayout, 'add', =>
        console.log 'Unit added'
        App.selectedComplex.units.add
          complex: App.selectedComplex.id


      @listenTo @unitListLayout, 'save:unit', =>
        console.log 'Unit saved'
        @trigger 'unit:list:add'

      @region.show @unitListLayout

  App.reqres.setHandler "unit:list", (options = {}) ->
    new UnitList.Controller options
