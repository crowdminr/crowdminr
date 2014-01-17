Template.returns.created = window.createGraph
Template.returns.rendered = ->
  @_bum ||= -> alert "bum"
  # only need to use stop if not inside a Deps.autorun
  @_stop = Loans.find().observe
    added: (newLoan) -> window.renderGraph()
    changed: (newLoan, oldLoan) -> renderGraph()
    removed: (oldLoan) -> renderGraph()

Template.returns.destroyed = ->
  @_bum()
  @_stop()
