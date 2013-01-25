Claudel.Views ||= {}

class Claudel.Views.Work extends Backbone.View
  
  template: JST["backbone/templates/work"]
  
  initialize: ->
    
  render: ->
    $(@el).html(@template( @model.toJSON() ))
    return this
    