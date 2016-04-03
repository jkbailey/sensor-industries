@Dashboard.module 'Concerns', (Concerns, App, Backbone, Marionette, $, _) ->

  Concerns.Validation =

    modelEvents:
      'validated:invalid': 'modelInvalid'

    initialize: ->
      Backbone.Validation.bind @

    onRender: ->
      @getFormDataContainer().find(':input').on 'focus', =>
        @hideErrors()
      @getFormDataContainer().find(':input').on 'blur', =>
        @showErrors()

    onDestroy: ->
      Backbone.Validation.unbind @
      @getFormDataContainer().find(':input').off 'focus blur keyup'

    addError: (key, message) ->
      el = @getFormDataContainer().find "[name=\"#{key}\"]"
      unless el.hasClass 'error'
        el.addClass 'error'
          .after "<span class=\"input-error\">#{message}</span>"
        $(el).on 'keyup', =>
          unless @model.preValidate key, el.val()
            @clearError key

    clearError: (key) ->
      el = @getFormDataContainer().find "[name=\"#{key}\"]"
      el.removeClass 'error'
        .siblings('.input-error').remove()
      $(el).off 'keyup'

    hideErrors: ->
      @$('input:not(:focus) + .input-error').hide()

    showErrors: ->
      @$('.input-error').show()

    modelInvalid: (errors) ->
      keys = _.keys errors
      _.each keys, (key) =>
        @addError key, errors[key]

      # Scroll to first error
      $('html,body').animate
        scrollTop: $('.input-error').first().offset().top - 75
      , 600

    preValidate: ->
      if errors = @model.preValidate @serialize()
        @model.trigger 'validated:invalid', errors
