class Claudel.Models.Type extends Backbone.Model
  paramRoot: 'type'

  defaults:
    name: null
    
class Claudel.Collections.Types extends Backbone.Collection
  model: Claudel.Models.Type
  url: '/types'
