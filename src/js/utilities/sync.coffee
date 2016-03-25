@Dashboard.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  Backbone.emulateHTTP = true;

  _sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    options.data = {} unless options.data

    # Global auth settings
    if App.user
      options.beforeSend = (xhr) ->
        xhr.setRequestHeader "Authorization", "Basic #{App.user.get('auth_string')}"

    if model? and (method in ['create', 'update', 'delete'])
      options.contentType = 'application/json'
      data = options.data
      _.extend data,
        options.attrs || model.toJSON(options)
      options.data = JSON.stringify data

    # Global error catching
    error = options.error
    options.error = (xhr, textStatus, errorThrown) ->
      App.vent.trigger 'global:error', "We are very sorry, there was a problem saving your data. Please refresh your browser and try again.\n\n#{xhr.status} - #{xhr.statusText}"
      if error then error.call xhr, textStatus, errorThrown

    sync = _sync.call @, method, model, options
    if !model._fetch and method is 'read'
      model._fetch = sync

    sync
