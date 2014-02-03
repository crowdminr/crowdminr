$ ->
  $(document).keydown (event) ->
    if event.which is 83
      Meteor.call 'deleteLoans'
