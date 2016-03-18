@Dashboard.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  tmpUser = 'test'
  tmpPass = 'test'
  tmpAuthString = btoa "#{tmpUser}:#{tmpPass}"

  class Entities.User extends Backbone.Model

    url: "http://dev.waterr8.com:8080/api/v1/customer/login"

    setAuthString: ->
      @set 'auth_string', btoa "casey:casey"

    validateUser: ->
      @setAuthString()

      @save null,
        success: =>
          if @get('company')
            App.company = App.request 'entities:company', @get('company')
            if @get('contacts')
              App.company.contacts = App.request 'entities:contacts', @get('contacts')
            App.company.complexes = App.request 'entities:complexes'
            @set 'userValid', true
            @trigger 'user:valid'
          else
            @trigger 'user:invalid'
        error: =>
          @trigger 'user:invalid'

    isLoggedIn: ->
      @get 'userValid'

  App.reqres.setHandler 'entities:user', (attrs) ->
    new Entities.User attrs
