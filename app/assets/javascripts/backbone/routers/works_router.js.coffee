class Claudel.Routers.WorksRouter extends Backbone.Router
  
  initialize: (options) ->
    @works = new Claudel.Collections.Works
    @works.add(options.works.models)
    #Seed Time Periods
    @timePeriods = new Claudel.Collections.TimePeriods
    @timePeriods.add(options.time_periods)
    #Seed Types
    @types = new Claudel.Collections.Types
    @types.add(options.types)
    #Seed Domains
    @domains = new Claudel.Collections.Domains
    @domains.add(options.domains)
    #Set default sort to random
    @currentSort = 'random'
    @view = new Claudel.Views.Index(@works)
    @show = new Claudel.Views.Show
      
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
    @currentSort = 'time'
    @view.render(@currentSort, @timePeriods)
  
  type: ->
    @hidePopover()
    @currentSort = 'type'
    @view.render(@currentSort, @types)
    
  domain: ->
    @hidePopover()
    @currentSort = 'domain'
    @view.render(@currentSort, @domains)
  
  random: ->
    @hidePopover()
    @currentSort = 'random'
    @view.render(@currentSort)
  
  work: (id) ->
    work = @works.get(id)
    @show.render(work, @currentSort)
  
  about: ->
    view = new Claudel.Views.About(@currentSort)