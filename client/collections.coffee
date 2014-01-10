@Loans = new Meteor.Collection

if Loans.find().count() is 0
  Loans.insert
    rate: 10
  Loans.insert
    rate: 11
  Loans.insert
    rate: 12
