Meteor.methods
  deleteLoans: ->
    loanIds = []
    Loans.find().forEach (doc, i) ->
      loanIds.push(doc._id) if i % 2

    Loans.remove
      _id:
        $in: loanIds
