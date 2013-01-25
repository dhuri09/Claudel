Claudel.Views ||= {}

class Claudel.Views.Index extends Backbone.View
  
  indexTemplate: JST["backbone/templates/index"]
  
  el: "#container"
  
  initialize: ->
  
  links: (param) ->
    @$('a').removeClass 'active'
    @$("a[data-type=#{param}]").addClass 'active'
    
  addAll: (works) ->
    _.each works.models, (work) =>
      view = new Claudel.Views.Work({model : work})
      $("#works").prepend(view.render().el)
    
  render: (param, works, collection) ->
    @$el.html(@indexTemplate())
    @links(param)
    if param == 'time'
      @renderTime(works, collection)
    else if param == 'domain'
      @renderDomain(works, collection)
    else if param == 'type'
      @renderType(works, collection)
    else
      @renderRandom(works)
    return this
  
  renderTime: (works) ->
    works = works.by_time()
    @addAll(works)
  
  renderDomain: (works) ->
    works = works.by_domain()
    @addAll(works)
  
  renderType: (works) ->
    works = works.by_type()
    @addAll(works)
  
  renderRandom: (works) ->
    works = works.random()
    @addAll(works)
