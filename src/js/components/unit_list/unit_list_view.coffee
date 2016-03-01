@Dashboard.module "Components.UnitList", (UnitList, App, Backbone, Marionette, $, _) ->

  class UnitList.Sensor extends Marionette.CompositeView
    template: JST['components/unit_list/templates/sensor']

  class UnitList.Unit extends Marionette.CompositeView
    template: JST['components/unit_list/templates/unit']
    childViewContainer: '.list-sensors'
    childView: UnitList.Sensor

  class UnitList.Layout extends Marionette.CompositeView
    template: JST['components/unit_list/templates/layout']
    childViewContainer: '.list-container'
    childView: UnitList.Unit

    triggers:
      'click .btn.add': 'add'
