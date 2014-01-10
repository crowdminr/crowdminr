window.story = new Miso.Storyboard
  initial: 'title'
  context: $('.content')
  scenes:
    title:
      enter: -> setTimeout (-> ($ '#title').addClass 'current'), 300
      exit: -> ($ '.slide').removeClass 'current'
    problem:
      enter: -> setTimeout (-> ($ '#problem').addClass 'current'), 300
      exit: -> ($ '.slide').removeClass 'current'
    solution:
      enter: -> setTimeout (-> ($ '#solution').addClass 'current'), 300
      exit: -> ($ '.slide').removeClass 'current'
    mockup:
      enter: ->
        ($ '.slide').removeClass 'current'
        setTimeout (-> Router.go 'home'), 300
      exit: -> Router.go 'about'
    stack:
      enter: -> setTimeout (-> ($ '#stack').addClass 'current'), 300
      exit: -> ($ '.slide').removeClass 'current'

Meteor.startup ->
  story.start()
   
  (->
    slides = ['title', 'problem', 'solution', 'mockup', 'stack']
    slide = 0
    $('body').keydown (e) ->
      # 37 is left arrow
      if e.keyCode is 39
        slide = Math.min ++slide, slides.length - 1
        story.to slides[slide]
      # 39 is right arrow
      if e.keyCode is 37
        slide = Math.max --slide, 0
        story.to slides[slide]

  )()
