Template.list.rendered = ->
  unless @_rendered
    # svg = d3.select @find 'svg.returns'
    # @_graph = new window.ReturnsGraph svg
    # # only need to use stop if not inside a Deps.autorun
    # sleepyGraphRender = window.sleepyCallback @_graph.render
    # @_graph_stopper = Loans.find().observe
    #   added: sleepyGraphRender
    #   changed: sleepyGraphRender
    #   removed: sleepyGraphRender

    Session.set 'listSize', 20
    Session.set 'risk', 1
    ul = d3.select @find 'ul.loans'
    @_list = new window.LoansList ul
    # only need to use stop if not inside a Deps.autorun
    sleepyListRender = window.sleepyCallback @_list.render
    @_list_stopper = Loans.find().observe
      added: sleepyListRender
      changed: sleepyListRender
      removed: sleepyListRender

    @_rendered = true

    $(@find '#risk-slider').slider(
      min: 0
      max: 1
      step: 0.01
      value: 1
      tooltip: 'hide'
    ).on('slide', (event) ->
      Session.set 'risk', event.value
    ).on('slideStop', (event) ->
      sleepyListRender())

      

Template.list.destroyed = ->
  # @_graph_stopper.stop()
  @_list_stopper.stop()

Template.list.helpers
  profile: ->
    switch
      when Session.get('risk') < 0.33 then "I need to be careful with my money"
      when Session.get('risk') < 0.67 then "I can take some risk to get a better return"
      else "I just want to go for the highest interest rates"

