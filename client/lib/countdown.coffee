class @Countdown
  constructor: (from, callback) ->
    active = true
    startTime = moment()
    endTime = startTime.add from

    timeLeft = ->
      moment.duration endTime.diff moment()

    done = ->
      timeLeft() < 0

    count = ->
      if active and not done()
        callback timeLeft()
        Meteor.setTimeout count, 1000

    Meteor.setTimeout count, 1000

    @stop = =>
      active = false

