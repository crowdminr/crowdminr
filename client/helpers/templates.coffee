Template.home.events
  'change select': (event) ->
    debugger
    Session.set 'sortBy', field

Template.list.loans = -> Loans.find({}, sort: [['rate', 'desc']])

Template.item.current = ->
  @_id is Session.get 'currentLoan'

Template.item.events
  'click': (event) ->
    event
    Session.set 'currentLoan', @_id
    # template data, if any, is available in 'this'

