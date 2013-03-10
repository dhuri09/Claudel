Claudel.Views ||= {}

class Claudel.Views.Work extends Backbone.View
  
  template: JST["backbone/templates/thumb"]
  
  className: "work"
  tagName: "a"
    
  initialize: ->
    
  render: ->
    $(@el).html(@template( @model.toJSON() ))
    $(@el).attr('href', '#works/' + @model.id).addClass("visible")
    $(@el).attr('data-id', @model.id)
    return this
    