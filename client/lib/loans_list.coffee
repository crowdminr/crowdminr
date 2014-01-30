template = (d) ->
  percent_funded = 100 * (d.funded_amnt / d.loan_amnt)
  """
  <div class="funding_bar" style="width: #{percent_funded}%">
    <div class="loan_stats">
      <div class="funding_percent">Filled: #{Math.round(percent_funded*10)/10}%</div>
      <div class="time_left"></div>
      <div class="net_return">Net return: #{Math.round(d.net_return*10)/10}%</div>
      <div class="risk">Risk: #{Math.round(d.exp_default_rate*10)/10}%</div>
    </div>
    <div class="hover_mask">
      <button type="button" class="btn btn-xs btn-default details">Details</button>
      <a href="#{d.url}" target="_blank">
        <button type="button" class="btn btn-xs btn-default go">Take me there!</button>
      </a>
    </div>
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

  loanComparator: (a, b) ->
    weight = (l) ->
      safety = (1 - Session.get 'risk')
      penalty = safety * l.exp_default_rate
      l.net_return - penalty

    weight_a = weight a
    weight_b = weight b

    switch
      when weight_a > weight_b then -1
      when weight_a < weight_b then 1
      else 0

  render: =>
    createCountdown = ->

      updateElement = (timeLeft) =>
        text = formatTime timeLeft
        $(@).text text

      updateUrgent = (timeLeft) =>
        fundingBar = d3.select(@parentNode.parentNode)
        urgent = timeLeft.asMinutes() < 30
        fundingBar.classed("urgent", urgent)

      loan = d3.select(@parentNode.parentNode.parentNode).datum()
      time = timeLeft loan
      new Countdown time, (timeLeft) ->
        updateElement timeLeft
        updateUrgent timeLeft


    loans = Loans.find()
                 .fetch()

    li_height = 60

    li = @ul.selectAll("li")
            .data(loans, (loan) -> loan.id)
            .filter (d, i) ->
              console.log "i: #{i}, cond: #{i < Session.get 'listSize'}"
              i < Session.get 'listSize'

    top = (d, i) -> "#{li_height * i}px"

    li.enter()
      .append('li')

    li.sort @loanComparator

    li.transition()
      .duration(750)
      .style("top", top)
      .style("opacity", 1)

    li.exit()
      .transition()
      .duration(750)
      .style("opacity", 0)
      .remove()

    li.html(template)
      .selectAll('.time_left')
      .each(createCountdown)

