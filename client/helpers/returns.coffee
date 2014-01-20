Template.returns.created = ->

Template.returns.rendered = ->
  unless @_graph
    svg = d3.select this.find 'svg.returns'
    @_graph = new window.ReturnsGraph svg
    # only need to use stop if not inside a Deps.autorun
    @_stop = Loans.find().observe
      added: @_graph.render
      changed: @_graph.render
      removed: @_graph.render

Template.returns.destroyed = ->
  @_stop()

