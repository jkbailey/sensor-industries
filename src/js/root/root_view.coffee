@Dashboard.module "Root", (Root, App, Backbone, Marionette, $, _) ->

  class Root.Layout extends Marionette.LayoutView
    el: '#content'
    template: JST['root/templates/layout']

    regions:
      header: '#header'
      body: '#body'
      overlay: '#overlay'
