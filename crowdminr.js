if (Meteor.isClient) {
  Template.slides.greeting = function () {
    return "Welcome to crowdminr.";
  };

  Template.slides.events({
    'click input' : function () {
      // template data, if any, is available in 'this'
      if (typeof console !== 'undefined')
        console.log("You pressed the button");
    }
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}



var story = new Miso.Storyboard({
  
  // start on the first pane
  initial : 'pane1',
 
  // set the context to an element we will be updating
  context : $('#walkthrough'),
  
  scenes : {
 
    pane1 : {
      enter : function() {
        this.append("First pane! <br />");
      },
      exit : function() {
        this.append("Done with first pane. <br />");
      }
    },
 
    pane2 : {
      enter : function() {
        this.append("Second pane! <br />");
      },
      exit : function() {
        this.append("Done with second pane. <br />");
      }
    },
 
    done : {}
  }
});
 
// this will kick things off on pane 1
story.start();
 
// then we will instruct the story to go to pane 2
story.to('pane2').then(function() {
 
  // when we've fully transitioned to pane 2, we will
  // tell the story to be done.
  story.to('done');
});
