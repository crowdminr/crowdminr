Template.list.rendered = ->
  unless @_rendered
    svg = d3.select @find 'svg.returns'
    @_graph = new window.ReturnsGraph svg
    # only need to use stop if not inside a Deps.autorun
    @_graph_stopper = Loans.find().observe
      added: @_graph.render
      changed: @_graph.render
      removed: @_graph.render

    ul = d3.select @find 'ul.loans'
    @_list = new window.LoansList ul
    # only need to use stop if not inside a Deps.autorun
    @_list_stopper = Loans.find().observe
      added: @_list.render
      changed: @_list.render
      removed: @_list.render

    @_rendered = true

Template.list.destroyed = ->
  @_graph_stopper.stop()
  @_list_stopper.stop()

Template.list.events
  'change select': (event) ->
    Session.set 'sortBy', field

