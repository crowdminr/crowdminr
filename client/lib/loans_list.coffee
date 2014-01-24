template = (d) ->
  percent_funded = 100 * (d.funded_amnt / d.loan_amnt)
  """
  <div class="funding_bar" style="width: #{percent_funded}%"></div>
  <div class="test">
    <div>#{percent_funded}%</div>
    <a href="#{d.url}" target="_blank">
      <button type="button" class="btn btn-primary">Take me there!</button>
    </a>
    <div class="time-left"></div>
  </div>
  """

# heuristic assuming loan funding rate is constant
timeLeft = (loan) ->
  percentFunded = 100 * (loan.funded_amnt / loan.loan_amnt)
  listDate = Date.parse loan.list_d
  now = new Date
  (100 - percentFunded) * (now - listDate) / percentFunded 

formatTime = (timeLeft) ->
  return "Time's up :(" if timeLeft < 0

  s = timeLeft.seconds()
  m = timeLeft.minutes()
  h = Math.floor timeLeft.asHours()

  string = "left"
  string = "#{s} seconds #{string} " if s > 0 and h is 0
  string = "#{m} minutes #{string} " if m > 0
  string = "#{h} hours #{string} " if h > 0
    
  "Around " + string

class @LoansList
  constructor: (@ul) ->

  render: =>
    createCountdown = ->
      element = @
      loan = d3.select(@parentNode.parentNode).datum()
      time = timeLeft loan

      updateElement = (timeLeft) ->
        text = formatTime timeLeft
        $(element).text text
    
      new Countdown time, updateElement

    li = @ul.selectAll("li")
            .data(Loans.find().fetch(), (loan) -> loan.id)
            .html(template)
#           .classed('current', (d) -> )

    li.enter()
      .append('li')

    li.exit().remove()

    li.html(template)
      .selectAll('.time-left')
      .each(createCountdown)

