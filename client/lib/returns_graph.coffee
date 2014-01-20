class @ReturnsGraph
  constructor: (@svg) ->
    margin =
      top: 20
      right: 20
      bottom: 30
      left: 40
    width = 960 - margin.left - margin.right
    height = 500 - margin.top - margin.bottom

    # scales
    @x = d3.scale.linear().range([0, width])
    @y = d3.scale.linear().range([height, 0])
    @color = d3.scale.category10()

    # axes
    @xAxis = d3.svg.axis().scale(@x).orient("bottom")
    @yAxis = d3.svg.axis().scale(@y).orient("left")

    # set sizes and positions
    @svg = @svg.attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
          .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    # axes
    @svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(@xAxis)
        .append("text")
        .attr("class", "label")
        .attr("x", width)
        .attr("y", -6)
        .style("text-anchor", "end")
        .text "Risk"
    @svg.append("g")
        .attr("class", "y axis")
        .call(@yAxis)
        .append("text")
        .attr("class", "label")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text "Return"

  render: =>
    # points
    data = Loans.find().fetch()

    # set the domains of the axes
    @x.domain([0, d3.max(data, (d) -> d.exp_default_rate )]).nice()
    @y.domain([0, d3.max(data, (d) -> d.int_rate)]).nice()

    @xAxis.scale(@x)
    @yAxis.scale(@y)
    @svg.select('.x.axis').call(@xAxis)
    @svg.select('.y.axis').call(@yAxis)

    @svg.selectAll(".dot")
        .data(data)
        .enter()
        .append("circle")
        .attr("class", "dot")
        .attr("id", (d) -> d.id)
        .attr("r", 3.5)
        .attr("cx", (d) => @x d.exp_default_rate)
        .attr("cy", (d) => @y d.int_rate)
        .style "fill", (d) => @color d.species

    #legend
    # legend = svg.selectAll(".legend")
    #             .data(color.domain())
    #             .enter()
    #             .append("g")
    #             .attr("class", "legend")
    #             .attr("transform", (d, i) -> "translate(0," + i * 20 + ")")
    # legend.append("rect")
    #       .attr("x", width - 18)
    #       .attr("width", 18)
    #       .attr("height", 18)
    #       .style "fill", color
    # legend.append("text")
    #       .attr("x", width - 24)
    #       .attr("y", 9)
    #       .attr("dy", ".35em")
    #       .style("text-anchor", "end")
    #       .text (d) -> 

