class Claudel.Routers.WorksRouter extends Backbone.Router
  
  initialize: (options) ->
    @works = new Claudel.Collections.Works
    @works.add(options.works.models)
    @view = new Claudel.Views.Index
      
  routes:
    "time" : "time"
    "type" : "type"
    "domain" : "domain"
    "random" : "random"
    ".*" : "time"
  
  time: ->
    timePeriods = new Claudel.Collections.TimePeriods
    timePeriods.fetch success: (timePeriods) =>
      console.log timePeriods
      @view.render('time', @works, timePeriods)
  
  type: ->
    types = new Claudel.Collections.Types
    types.fetch success: (types) =>
      console.log types
      @view.render('type', @works, types)
    
  domain: ->
    domains = new Claudel.Collections.Domains
    domains.fetch success: (domains) =>
      console.log domains
      @view.render('domain', @works, domains)
  
  random: ->
    @view.render('random', @works)