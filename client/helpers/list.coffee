Template.list.rendered = ->
  unless @_rendered
    svg = d3.select @find 'svg.returns'
    @_graph = new window.ReturnsGraph svg
    # only need to use stop if not inside a Deps.autorun
    sleepyGraphRender = window.sleepyCallback @_graph.render
    @_graph_stopper = Loans.find().observe
      added: sleepyGraphRender
      changed: sleepyGraphRender
      removed: sleepyGraphRender

    ul = d3.select @find 'ul.loans'
    @_list = new window.LoansList ul
    # only need to use stop if not inside a Deps.autorun
    sleepyListRender = window.sleepyCallback @_list.render
    @_list_stopper = Loans.find().observe
      added: sleepyListRender
      changed: sleepyListRender
      removed: sleepyListRender

    @_rendered = true

Template.list.destroyed = ->
  @_graph_stopper.stop()
  @_list_stopper.stop()

Template.list.events
  'change select': (event) ->
    Session.set 'sortBy', field

