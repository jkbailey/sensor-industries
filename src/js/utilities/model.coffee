@Dashboard.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  Backbone.Model.prototype.parse = (response, xhr) ->
    if response.status is "OK"
      JSON.parse response.model
    else
      App.trigger 'error', response
      alert response
