Template.returns.created = ->

Template.returns.rendered = ->
  unless @_graph
    svg = d3.select @find 'svg.returns'
    @_graph = new window.ReturnsGraph svg
    # only need to use stop if not inside a Deps.autorun
    @_stop_graph = Loans.find().observe
      added: @_graph.render
      changed: @_graph.render
      removed: @_graph.render

  unless @_list
    ul = d3.select @find 'ul.loans'
    @_list = new window.LoansList ul
    # only need to use stop if not inside a Deps.autorun
    @_stop_list = Loans.find().observe
      added: @_list.render
      changed: @_list.render
      removed: @_list.render

Template.returns.destroyed = ->
  @_stop_graph()
  @_stop_list()

