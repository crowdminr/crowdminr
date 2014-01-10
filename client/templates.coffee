Template["list-ranking"].loans = -> Loans.find({}, sort: [['rate', 'desc']])

Template["list-ranking"].events
  'click input': ->
    # template data, if any, is available in 'this'

