Claudel.Views ||= {}

class Claudel.Views.About extends Backbone.View
  
  template: JST["backbone/templates/about"]
  
  el: '#popover'
    
  initialize: (sort) ->
    @sort = sort
    @render()
    $('body').keyup(@key)
  
  showPopover: ->
    $("#popover").removeClass "hidden"
  
  setLinks: ->
    @showPopover()
    $('.close').attr("href", "#" + @sort)
  
  render: ->
    $(@el).html( @template() )
    @setLinks()
    return this
  
  events:
    "click .cover" : "close"
  
  close: ->
    window.location = "#" + @sort
  
  key: (event) =>
    if event.keyCode == 27
      window.location = "#" + @sort