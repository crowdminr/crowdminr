Accounts.config
  sendVerificationEmail: true
  forbidClientAccountCreation: false

# Accounts.onCreateUser (options, user) ->
#   # personal info
#   accessToken = user.services.facebook.accessToken
#   me = Meteor.http.get 'https://graph.facebook.com/me',
#     params:
#       access_token: accessToken

#   if me.error
#     throw me.error

#   profile = _.pick me.data,
#     'id',
#     'name',
#     'email',
#     'first_name',
#     'last_name',
#     'username',
#     'link',
#     'gender',
#     'locale',
#     'languages',
#     'hometown',
#     'location',
#     'picture',
#     'timezone',
#     'age_range',
#     'verified',
#     'currency'

#   # picture
#   # get user picture ?type=square | small | normal | large
#   # If you specify ?redirect=false, this connection will return the URL of the profile picture without a 302 redirect.
#   profile.avatarUrl ||= "http://graph.facebook.com/#{profile.username}/picture?type=square"

#   # friends
#   friends = Meteor.http.get "https://graph.facebook.com/me/friends",
#     params:
#       access_token: accessToken

#   # add to user
#   user.profile ||= {}
#   _.extend user.profile, profile
#   user.friends = friends.data

#   user

ServiceConfiguration.configurations.remove
  service: 'facebook'

ServiceConfiguration.configurations.insert
  service: 'facebook'
  appId: Meteor.settings.facebook.appId
  secret: Meteor.settings.facebook.secret

# Accounts.loginServiceConfiguration.remove
#   service: 'google'

# Accounts.loginServiceConfiguration.insert
#   service: 'google'
#   clientId: '591655014563.apps.googleusercontent.com'
#   secret: 'JbEsdqMCool2XVTV_xHOaFH_'

# Accounts.emailTemplates.siteName = "crowdminr.io"
# Accounts.emailTemplates.from = "Hot Loans <info@crowdminr.io>"
# Accounts.emailTemplates.enrollAccount.subject = (user) ->
#   "Welcome to Crowdminr, #{user.profile.name}!"

# Accounts.emailTemplates.enrollAccount.text = (user, url) ->
#   """
#   You're well on your way to simple, stress-free investing and earning a great interest rate.
#   To activate your account, simply click the link below:

#   #{url}
#   """
