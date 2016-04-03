@Dashboard.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  parseFunc = (response, xhr) ->
    return response unless response.status
    if response.status is "OK"
      JSON.parse response.model
    else
      App.trigger 'error', response
      alert response

  Backbone.Model.prototype.parse = parseFunc
  Backbone.Collection.prototype.parse = parseFunc
