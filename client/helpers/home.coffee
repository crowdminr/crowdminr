Template.navbar.rendered = ->
  unless @_rendered
    ($ @find "#navbar_center").sticky
      topSpacing: 0
      className: "sticked"
      wrapperClassName: "sticked_wrapper"
    @_rendered = true
