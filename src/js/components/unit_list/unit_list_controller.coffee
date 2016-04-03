@Dashboard.module "Components.UnitList", (UnitList, App, Backbone, Marionette, $, _) ->

  class UnitList.Controller extends Marionette.Controller

    initialize: (options = {}) ->
      { @region } = options || {}
      @unitListLayout = new UnitList.Layout
        collection: App.selectedComplex.units

      @listenTo @unitListLayout, 'add', =>
        App.selectedComplex.units.add
          complex: App.selectedComplex.id


      @listenTo @unitListLayout, 'childview:save:unit', (view) =>
        unless view.preValidate()
          xhr = view.model.save view.serialize()
          $.when(xhr).then =>
            view.triggerMethod 'saved'

      @region.show @unitListLayout

  App.reqres.setHandler "unit:list", (options = {}) ->
    new UnitList.Controller options
