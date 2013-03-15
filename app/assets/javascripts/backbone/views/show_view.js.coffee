Claudel.Views ||= {}

class Claudel.Views.Show extends Backbone.View
  
  template: JST["backbone/templates/work"]
  
  el: '#popover'
    
  reset: (work, sort) ->
    $('body').on("keyup", @key)
    @model = work
    @sort = sort
    @render()
  
  showPopover: ->
    $("#popover").removeClass "hidden"
  
  setLinks: ->
    @showPopover()
    $('.close').attr("href", "#" + @sort)
  
  appendImage: (images, index) ->
    $(".work-images").html('<img data-num="' + index + '" src=' + images[index].url + ' />')
    $(".work-images img").on("load", =>
      maxWidth = $(".work-images").width()
      width = $(".work-images img").width()
      if width > maxWidth
        $(".work-images img").addClass "heighted"
        maxHeight = $(".work-images").height()
        height = $(".work-images img").height()
        $(".work-images img").css("margin-top", (maxHeight - height)/2)
      $(".work-images").removeClass "loading"
      $(".work-images img").addClass "loaded"
      @addArrows()
    )
  
  addArrows: ->
    length = @model.get('images').length
    unless length <= 1
      $(".work-images").append("<div id='left-arrow'></div><div id='right-arrow'></div>")
    
  addImages: =>
    images = @model.get('images')
    if _.isEmpty(images)
      $(".work-images").removeClass("loading").append('<div class="message">No Images...</div>')
    else
      @appendImage(images, 0)
  
  nextImage: =>
    images = @model.get('images')
    length = @model.get('images').length
    unless length <= 1
      i = $(".work-images img").data("num")
      if (i+1) == length
        @appendImage(images, 0)
      else
        @appendImage(images, i+1)
  
  previousImage: =>
    images = @model.get('images')
    length = @model.get('images').length
    unless length <= 1
      i = $(".work-images img").data("num")
      if i == 0
        @appendImage(images, (length-1))
      else
        @appendImage(images, i-1)
            
  render: ->
    $(@el).html(@template( @model.toJSON() ))
    @setLinks()
    @model.fetchImages().then @addImages
    return this
  
  events:
    "click .cover" : "close"
    "click #right-arrow" : "nextImage"
    "click #left-arrow" : "previousImage"
  
  close: ->
    window.location = "#" + @sort
    $('body').off("keyup", @key)
  
  key: (event) =>
    if event.keyCode == 27
      @close()
    else if event.keyCode == 39
      @nextImage()
    else if event.keyCode == 37
      @previousImage()