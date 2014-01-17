Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'

Router.map ->
  @route 'home',
    path: '/'
    template: 'home'

  @route 'about',
    path: '/about'

  @route 'returns',
    path: '/returns'
