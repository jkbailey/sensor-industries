@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.Serialize =

    getFormDataContainer: ->
      if @formContainer
        return @$ @formContainer
      else
        return @$el

    serialize: ->
      Backbone.Syphon.serialize @getFormDataContainer()

    onRender: ->
      Backbone.Syphon.deserialize @getFormDataContainer(), @model.attributes
