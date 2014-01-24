Meteor.publish 'loans', ->
  Loans.find {},
    fields:
      id: 1
      title: 1
      loan_amnt: 1
      funded_amnt: 1
      term: 1
      int_rate: 1
      exp_default_rate: 1
      url: 1
      addr_city: 1
      addr_state: 1
      list_d: 1
      exp_d: 1
