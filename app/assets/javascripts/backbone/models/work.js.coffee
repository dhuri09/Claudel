class Claudel.Models.Work extends Backbone.Model
  paramRoot: 'work'

  defaults:
    name: null

class Claudel.Collections.Works extends Backbone.Collection
  model: Claudel.Models.Work
  url: '/works'
  
  comparator: (work) ->
    if @_order_by == 'time'
      return work.get('time_period').name
    else if @_order_by == 'type'
      return work.get('type').name
    else
      return work.get('domain').name
  
  by_time: ->
    @_order_by = 'time'
    @sort()
  
  by_type: ->
    @_order_by = 'type'
    @sort()
  
  by_domain: ->
    @_order_by = 'domain'
    @sort()
  
  random: ->
    @models = _.shuffle(@models)
    return @