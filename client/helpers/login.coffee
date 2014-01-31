Template.loggedInButton.helpers
  name: -> Meteor.user().profile.name

Template.loggedInButton.events
  'click a#logout': ->
    Meteor.logout ->
      console.log "Logged out!"

Template.loggedOutButton.events
  'click a#login': ->
    Meteor.loginWithFacebook ->
      console.log "Logged in!"

