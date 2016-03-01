@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  tmpUser = 'test'
  tmpPass = 'test'
  tmpAuthString = btoa "#{tmpUser}:#{tmpPass}"

  class Entities.User extends Backbone.Model

    defaults:
      id: 1
      company_id: 1

    localStorage: new Backbone.LocalStorage "User"

    initialize: ->
      @fetch()

    setAuthString: ->
      @set 'auth_string', btoa "#{@get('username')}:#{@get('password')}"
      @unset 'username'
      @unset 'password'
      @save()

    validateUser: ->
      testAuthString = btoa "#{@get('username')}:#{@get('password')}"

      if testAuthString is tmpAuthString
        @setAuthString()
        @trigger 'user:valid'
      else
        @trigger 'user:invalid'

    isLoggedIn: ->
      @get('auth_string')?

  App.reqres.setHandler 'entities:user', (attrs) ->
    new Entities.User attrs
