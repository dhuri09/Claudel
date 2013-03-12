class Claudel.Routers.WorksRouter extends Backbone.Router
  
  initialize: (options) ->
    @works = new Claudel.Collections.Works
    @works.add(options.works.models)
    @currentSort = 'random'
    @view = new Claudel.Views.Index(@works)
      
  routes:
    "time" : "time"
    "type" : "type"
    "domain" : "domain"
    "random" : "random"
    "works/:id" : "work"
    "about" : "about"
    ".*" : "random"
  
  hidePopover: ->
    $("#popover").html('')
    $("#popover").addClass "hidden"
    
  time: ->
    @hidePopover()
    timePeriods = new Claudel.Collections.TimePeriods
    timePeriods.fetch success: (timePeriods) =>
      @currentSort = 'time'
      @view.render(@currentSort, timePeriods)
  
  type: ->
    @hidePopover()
    types = new Claudel.Collections.Types
    types.fetch success: (types) =>
      @currentSort = 'type'
      @view.render(@currentSort, types)
    
  domain: ->
    @hidePopover()
    domains = new Claudel.Collections.Domains
    domains.fetch success: (domains) =>
      @currentSort = 'domain'
      @view.render(@currentSort, domains)
  
  random: ->
    @hidePopover()
    @currentSort = 'random'
    @view.render(@currentSort)
  
  work: (id) ->
    work = @works.get(id)
    view = new Claudel.Views.Show(work, @currentSort)
  
  about: ->
    view = new Claudel.Views.About(@currentSort)