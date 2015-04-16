@currentTime = new ReactiveVar moment()

Meteor.setInterval (-> currentTime.set moment() ), 1000*5
