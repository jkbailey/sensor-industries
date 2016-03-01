@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.Serialize =

    serialize: ->
      Backbone.Syphon.serialize @

    deserialize: ->
      Backbone.Syphon.deserialize @, @model.attributes
