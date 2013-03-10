Claudel.Views ||= {}

class Claudel.Views.Show extends Backbone.View
  
  template: JST["backbone/templates/work"]
  
  el: '#popover'
    
  initialize: (work, sort) ->
    @model = work
    @sort = sort
    @render()
    $('body').keyup(@escape)
  
  showPopover: ->
    $("#popover").removeClass "hidden"
  
  setLinks: ->
    @showPopover()
    $('.close').attr("href", "#" + @sort)
  
  addImages: =>
    images = @model.get('images')
    if _.isEmpty(images)
      $(".work-images").append('<div class="message">No Images...</div>')
    else
      for image in @model.get('images')
        $(".work-images").append('<img src=' + image.url + ' />')
    
  render: ->
    $(@el).html(@template( @model.toJSON() ))
    @setLinks()
    @model.fetchImages().then @addImages
    return this
  
  events:
    "click .cover" : "close"
  
  close: ->
    window.location = "#" + @sort
  
  escape: (event) =>
    if event.keyCode == 27
      window.location = "#" + @sort