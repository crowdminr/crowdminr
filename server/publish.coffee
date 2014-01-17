Meteor.publish 'loans', ->
  Loans.find {},
    fields:
      loan_amnt: 1
      funded_amnt: 1
      term: 1
      int_rate: 1
      exp_default_rate: 1
      url: 1
      addr_city: 1
      addr_state: 1
