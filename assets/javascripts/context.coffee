window.AP = new Backbone.Marionette.Application
  Models: {}
  Collections: {}
  Views: {}
  Layouts: {}
  Routers: {}
  initialize: ->
    AP.addInitializer ->
      AP.addRegions
        header: "#header"
        main: "#container"
        footer: "#footer"
      # set views
      AP.header.show(new AP.Views.LayoutsHeader())
      AP.footer.show(new AP.Views.LayoutsFooter())
      # set router
      AP.router = new AP.Routers.Main()
      Backbone.history.start({pushState: true, root: '/'})
      $(document).on 'click', "a[href^='/']", (e) ->
        url = $(this).attr('href').substr(1)
        AP.router.navigate url, {trigger: true}
        e.preventDefault()
    AP.start({pushState: true, root: '/'})

$ ->
  AP.initialize()