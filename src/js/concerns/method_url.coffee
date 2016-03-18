@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.MethodToURL =

    initialize: ->
      console.log 'init contact'
      console.log @sync

    sync: (method, model, options) ->
      options = options || {}
      options.url = model.methodToURL[method.toLowerCase()].call @
      console.log method, options.url
      Backbone.sync method, model, options
