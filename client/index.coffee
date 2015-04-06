currentTime = new ReactiveVar new Date

Meteor.setInterval (-> currentTime.set new Date ), 1000*5

Template.header.helpers
  formattedTime: -> moment(currentTime.get()).format('HH:mm')
  formattedDate: -> moment(currentTime.get()).format('ddd DD MMM')
