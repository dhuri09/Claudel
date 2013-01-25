class Claudel.Models.TimePeriod extends Backbone.Model
  paramRoot: 'time_period'

  defaults:
    name: null
    
class Claudel.Collections.TimePeriods extends Backbone.Collection
  model: Claudel.Models.TimePeriod
  url: '/time_periods'
