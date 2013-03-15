Claudel.Views ||= {}

class Claudel.Views.Show extends Backbone.View
  
  template: JST["backbone/templates/work"]
  
  el: '#popover'
    
  initialize: ->
  
  showPopover: ->
    $("#popover").removeClass "hidden"
  
  setLinks: ->
    @showPopover()
    $('.close').attr("href", "#" + @sort)
  
  appendImage: (images, index) ->
    $(".work-images").html('<img data-num="' + index + '" src=' + images[index].url + ' />')
    $(".work-images img").on("load", ->
      maxWidth = $(".work-images").width()
      width = $(".work-images img").width()
      if width > maxWidth
        $(".work-images img").addClass "heighted"
        maxHeight = $(".work-images").height()
        height = $(".work-images img").height()
        $(".work-images img").css("margin-top", (maxHeight - height)/2)
      $(".work-images").removeClass "loading"
      $(".work-images img").addClass "loaded"
    )
    
  addImages: =>
    images = @model.get('images')
    if _.isEmpty(images)
      $(".work-images").removeClass("loading").append('<div class="message">No Images...</div>')
    else
      @appendImage(images, 0)
  
  nextImage: =>
    images = @model.get('images')
    i = $(".work-images img").data("num")
    length = @model.get('images').length
    unless length <= 1
      if (i+1) == length
        @appendImage(images, 0)
      else
        @appendImage(images, i+1)
  
  previousImage: =>
    images = @model.get('images')
    i = $(".work-images img").data("num")
    length = @model.get('images').length
    unless length <= 1
      if i == 0
        @appendImage(images, (length-1))
      else
        @appendImage(images, i-1)
            
  render: (work, sort) ->
    @model = work
    @sort = sort
    $('body').keyup(@key)
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