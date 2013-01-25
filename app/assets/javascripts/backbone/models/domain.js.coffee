class Claudel.Models.Domain extends Backbone.Model
  paramRoot: 'domain'

  defaults:
    name: null
    
class Claudel.Collections.Domains extends Backbone.Collection
  model: Claudel.Models.Domain
  url: '/domains'
