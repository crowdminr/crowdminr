template = (d) ->
  funding_percent = 100 * (d.funded_amnt / d.loan_amnt)
  """
  <h4>#{d.title}</h4>
  <div class="details">
  <p>Address: #{d.addr_city}, #{d.addr_state}</p>
  <p>Interest rate: #{d.int_rate}</p>
  <p>Default rate: #{d.exp_default_rate}</p>
  <p>Term: #{d.term} months</p>
  <div class="progress progress-striped active">
    <div class="progress-bar" role="progressbar" aria-valuenow="#{funding_percent}" aria-valuemin="0" aria-valuemax="100" style="width: #{funding_percent}%">
      <span class="sr-only">#{funding_percent}% Complete</span>
    </div>
  </div>
  <div class="row">
    <div class="col-md-4">$#{d.funded_amnt}<br />FUNDED</div>
    <div class="col-md-4">$#{d.loan_amnt}<br />GOAL</div>
    <div class="col-md-4">#{d.finishes}<br />HOURS LEFT</div>
  </div>
  <a href="#{d.url}" target="_blank">
    <button type="button" class="btn btn-primary">Show me the loan!</button>
  </a>
  """

class @LoansList
  constructor : (@ul) ->

  render: =>
    li = @ul.selectAll("li")
            .data(Loans.find().fetch())
            .html(template)

    li.enter()
      .append('li')
      .html(template)

    li.exit().remove()



# @createList = ->

# @renderList = ->
#   data = Loans.find().fetch()

#   ul = d3.select('ul.loans')
#          .selectAll('li')
#          .data(data)
#          .classed('current', (d) -> )
#          .html(template)
