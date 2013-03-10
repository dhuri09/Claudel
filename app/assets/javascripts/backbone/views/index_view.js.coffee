Claudel.Views ||= {}

class Claudel.Views.Index extends Backbone.View
  
  indexTemplate: JST["backbone/templates/index"]
  timeTemplate: JST["backbone/templates/time/index"]
  domainTemplate: JST["backbone/templates/domain/index"]
  typeTemplate: JST["backbone/templates/type/index"]
  randomTemplate: JST["backbone/templates/random/index"]
  
  el: "body"
  
  initialize: (works) ->
    $("#container").html(@indexTemplate())
    @works = works
    @addAll("#works", @works.models)
  
  # Resets links on sides of #works
  resetLinks: (param) ->
    $("#time").html('<a href="#time" data-type="time">Sort by Time</a>')
    $("#domain").html('<a href="#domain" data-type="domain">Sort by Domain</a>')
    $("#type").html('<a href="#type" data-type="type">Sort by Type</a>')
    $("#random").html('<a href="#random" data-type="random">Random</a>')
  
  #add works to div with data-id=id  
  addAll: (div, works, id) ->
    delay = 0
    for work in works
      #Add to works
      view = new Claudel.Views.Work({model: work})
      $("#works").append(view.render().el)
      #Center
      div = $('.work[data-id="' + work.id + '"]')
      top = $("#works").height()/2 - 25 + "px"
      left = $("#works").width()/2 - 25 + "px"
      div.css({"top": "#{top}", "left": "#{left}" })
  
  #add one work to specified html
  addOne: (html, work) ->
    view = new Claudel.Views.Work({model : work})
    html.append(view.render().el)
  
  #decide which parameter to search by and call it
  sort: ->
    if @param == 'time'
      @renderTime(@works, @collection)
    else if @param == 'domain'
      @renderDomain(@works, @collection)
    else if @param == 'type'
      @renderType(@works, @collection)
    else
      @renderRandom(@works)
  
  #render, reset function   
  render: (param, collection) ->
    #Reset values
    @resetLinks(param)
    @param = param
    @collection = collection
    @sort()
    return this
  
  #sort by time  
  renderTime: (works, collection) ->
    $("#time").html('<table id="time-key"><tr></tr></table>')
    works = _.groupBy(works.models, (work) -> work.get('time_period').id )
    for time in collection.models
      vals = works[time.id]
      unless _.isEmpty(vals)
        $("#time-key tr").append(@timeTemplate(time.toJSON()))
    for time in collection.models
      set = works[time.id]
      unless _.isEmpty(set)
        height = $("#works").height() - 50
        left = $('.time_period-name[data-id=' + time.id + ']').offset().left - 125
        left = left + $('.time_period-name[data-id=' + time.id + ']').width()/2
        for work, i in set
          div = $('.work[data-id="' + work.id + '"]')
          coordx = left + "px"
          coordy = height - 10 - i*60 + "px"
          div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)
  
  #sort by domain
  renderDomain: (works, collection) ->
    $("#domain").html('<table id="domain-key"></table>')
    works = _.groupBy(works.models, (work) -> work.get('domain').id )
    for domain in collection.models
      $("#domain-key").append(@domainTemplate(domain.toJSON()))
    for domain in collection.models
      set = works[domain.id]
      width = $("#works").width() - 50
      max = set.length*60 + 20
      if max/width > 1
        top = $('.domain-name[data-id=' + domain.id + ']').offset().top - 135
        top = top + ($('.domain-name[data-id=' + domain.id + ']').height()/2)
        for work, i in set
          div = $('.work[data-id="' + work.id + '"]')
          half = Math.floor(set.length/2)
          if i > half
            coordx = 10 + i*60 - (half+1)*60 + "px"
            coordy = top + 60 + "px"
          else
            coordx = 10 + i*60 + "px"
            coordy = top + "px"
          div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)
      else
        top = $('.domain-name[data-id=' + domain.id + ']').offset().top - 105
        top = top + ($('.domain-name[data-id=' + domain.id + ']').height()/2)
        for work, i in set
          div = $('.work[data-id="' + work.id + '"]')
          coordx = 10 + i*60 + "px"
          coordy = top + "px"
          div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)
  
  #sort by type
  renderType: (works, collection) ->
    $("#type").html('<table id="type-key"></table>')
    works = _.groupBy(works.models, (work) -> work.get('type').id )
    for type in collection.models
      $("#type-key").append(@typeTemplate(type.toJSON()))
    for type in collection.models
      set = works[type.id]
      width = $("#works").width() - 50
      max = set.length*60 + 20
      if max/width > 1
        top = $('.type-name[data-id=' + type.id + ']').offset().top - 135
        top = top + ($('.type-name[data-id=' + type.id + ']').height()/2)
        for work, i in set
          div = $('.work[data-id="' + work.id + '"]')
          half = Math.floor(set.length/2)
          if i > half
            coordx = width - 10 - (i*60) + (half+1)*60 + "px"
            coordy = top + 60 + "px"
          else
            coordx = width - 10 - (i*60) + "px"
            coordy = top + "px"
          div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)
      else
        top = $('.type-name[data-id=' + type.id + ']').offset().top - 105
        top = top + ($('.type-name[data-id=' + type.id + ']').height()/2)
        for work, i in set
          div = $('.work[data-id="' + work.id + '"]')
          coordx = width - 10 - (i*60) + "px"
          coordy = top + "px"
          div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)
  
  #sort random, also default sort
  renderRandom: (works) ->
    width = $("#works").width() - 50
    height = $("#works").height() - 50
    for work in works.models
      div = $('.work[data-id="' + work.id + '"]')
      x = Math.floor(Math.random()*(width/50))
      y = Math.floor(Math.random()*(height/50))
      coordx = x*50 + 7 + "px"
      coordy = y*50 + 7 + "px"
      div.animate({"top": "#{coordy}", "left": "#{coordx}" }, 500)