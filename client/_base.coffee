@currentTime = new ReactiveVar moment()

Meteor.setInterval (-> currentTime.set moment() ), 1000*5

TD.timeFormat = 'HH:mm'
TD.dateFormat = 'DD.MM.YYYY'
