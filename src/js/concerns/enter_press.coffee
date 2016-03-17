@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.EnterPress =

    keyboardEvents:
      'enter': 'enterPressed'

    onRender: ->
      @$('input').addClass 'mousetrap'

    enterPressed: ->
      @trigger 'submit'
