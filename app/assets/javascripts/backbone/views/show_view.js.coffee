Claudel.Views ||= {}

class Claudel.Views.Show extends Backbone.View
  
  template: JST["backbone/templates/work"]
  
  el: '#popover'
    
  initialize: (work, sort) ->
    @model = work
    @sort = sort
    @render()
    $('body').keyup(@key)
  
  showPopover: ->
    $("#popover").removeClass "hidden"
  
  setLinks: ->
    @showPopover()
    $('.close').attr("href", "#" + @sort)
  
  appendImage: (index) =>
    $(".work-images").html('<img data-num="' + index + '" src=' + @model.get('images')[index].url + ' />')
    $(".work-images img").on("load", ->
      maxWidth = $(".work-images").width()
      width = $(".work-images img").width()
      if width > maxWidth
        $(".work-images img").addClass "heighted"
        maxHeight = $(".work-images").height()
        height = $(".work-images img").height()
        $(".work-images img").css("margin-top", (maxHeight - height)/2)
        $(".work-images img").addClass "loaded"
    )
    
  addImages: =>
    images = @model.get('images')
    if _.isEmpty(images)
      $(".work-images").append('<div class="message">No Images...</div>')
    else
      @appendImage(0)
  
  nextImage: =>
    i = $(".work-images img").data("num")
    length = @model.get('images').length
    unless length <= 1
      if (i+1) == length
        alert 'end'
        @appendImage(0)
      else
        @appendImage(i+1)
  
  previousImage: =>
    i = $(".work-images img").data("num")
    length = @model.get('images').length
    unless length <= 1
      if i == 0
        @appendImage((length-1))
      else
        @appendImage(i-1)
            
  render: ->
    $(@el).html(@template( @model.toJSON() ))
    @setLinks()
    @model.fetchImages().then @addImages
    return this
  
  events:
    "click .cover" : "close"
  
  close: ->
    window.location = "#" + @sort
  
  key: (event) =>
    if event.keyCode == 27
      window.location = "#" + @sort
    else if event.keyCode == 39
      @nextImage()
    else if event.keyCode == 37
      @previousImage()