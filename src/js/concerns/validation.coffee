@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.Validation =

    modelEvents:
      'validated:invalid': 'modelInvalid'

    initialize: ->
      console.log 'validation init', @
      Backbone.Validation.bind @

    onRender: ->
      @getFormDataContainer().find(':input').on 'focus', =>
        @hideErrors()
      @getFormDataContainer().find(':input').on 'blur', =>
        @showErrors()

    onDestroy: ->
      console.log 'unbind validation'
      Backbone.Validation.unbind @
      @getFormDataContainer().find(':input').off 'focus blur keyup'

    addError: (key, message) ->
      el = @getFormDataContainer().find "[name=\"#{key}\"]"
      unless el.hasClass 'error'
        el.addClass 'error'
          .after "<span class=\"input-error\">#{message}</span>"
        $(el).on 'keyup', =>
          console.log 'keyup after error', @model.preValidate key, el.val()
          unless @model.preValidate key, el.val()
            @clearError key

    clearError: (key) ->
      console.log 'clear error', key
      el = @getFormDataContainer().find "[name=\"#{key}\"]"
      el.removeClass 'error'
        .siblings('.input-error').remove()
      $(el).off 'keyup'

    hideErrors: ->
      console.log 'hide errors'
      @$('input:not(:focus) + .input-error').hide()

    showErrors: ->
      console.log 'show errors'
      @$('.input-error').show()

    modelInvalid: (errors) ->
      keys = _.keys errors
      _.each keys, (key) =>
        @addError key, errors[key]

    preValidate: ->
      if errors = @model.preValidate @serialize()
        @model.trigger 'validated:invalid', errors
