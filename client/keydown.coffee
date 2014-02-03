$ ->
  $(document).keydown (event) ->
    if event.which is 83
      Meteor.call 'deleteLoans'

      $('.alert').slideDown()
      Meteor.setTimeout (-> $('.alert').slideUp()), 3000
