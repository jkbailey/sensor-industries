@Dashboard.module "Components.UnitList", (UnitList, App, Backbone, Marionette, $, _) ->

  class UnitList.Sensor extends Marionette.CompositeView
    template: JST['components/unit_list/templates/sensor']

  class UnitList.Unit extends Marionette.CompositeView
    template: JST['components/unit_list/templates/unit']
    childViewContainer: '.list-sensors'
    childView: UnitList.Sensor
    className: 'form-container unit-container'

    ui:
      editBar: '.edit-bar'

    triggers:
      'click .btn.save': 'save:unit'

    onRender: ->
      unless @model.isNew()
        @ui.editBar.hide()

    onSaved: ->
      @ui.editBar.hide()

    @include 'Serialize', 'Validation'

  class UnitList.Layout extends Marionette.CompositeView
    template: JST['components/unit_list/templates/layout']
    childViewContainer: '.list-container'
    childView: UnitList.Unit

    triggers:
      'click .btn.add': 'add'
