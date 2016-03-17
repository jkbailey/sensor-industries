@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.MethodToURL =

    sync: (method, model, options) ->
      options = options || {}
      options.url = model.methodToURL[method.toLowerCase()].call @

      Backbone.sync.apply @, arguments
