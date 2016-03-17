@Dashboard.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  _sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    options.data = {} unless options.data

    if App.user
      options.beforeSend = (xhr) ->
        xhr.setRequestHeader "Authorization", "Basic #{App.user.get('auth_string')}"

    if model? and (method in ['create', 'update', 'delete'])
      options.contentType = 'application/json'
      data = options.data
      _.extend data,
        options.attrs || model.toJSON(options)
      options.data = JSON.stringify data

    sync = _sync.call @, method, model, options
    if !model._fetch and method is 'read'
      model._fetch = sync

    sync
