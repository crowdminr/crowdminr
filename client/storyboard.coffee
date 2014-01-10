window.story = new Miso.Storyboard
  initial: 'title'
  context: $('.content')
  scenes:
    title:
      enter: -> ($ '#title').addClass 'current'
      exit: -> ($ '#title').removeClass 'current'
    problem:
      enter: -> ($ '#problem').addClass 'current'
      exit: -> ($ '#problem').removeClass 'current'
    solution:
      enter: -> ($ '#solution').addClass 'current'
      exit: -> ($ '#solution').removeClass 'current'
    mockup:
      enter: -> ($ '#mockup').addClass 'current'
      exit: -> ($ '#mockup').removeClass 'current'
    stack:
      enter: -> ($ '#stack').addClass 'current'
      exit: -> ($ '#stack').removeClass 'current'

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
# story.to('pane2').then -> story.to('done')
#


