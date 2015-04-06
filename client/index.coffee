currentTime = new ReactiveVar moment()

Meteor.setInterval (-> currentTime.set moment() ), 1000*5

Template.header.helpers
  formattedTime: ->
    currentTime.get().format('HH:mm')

  formattedDate: ->
    currentTime.get().format('ddd DD MMM')

  namedays: ->
    now = currentTime.get()
    Namedays.find({ month: now.month() + 1, day: now.date() }, { sort: { name: 1 }}).fetch()

Template.weather.helpers
  forecasts: ->
    Forecasts.find({}, { sort: { from: 1 }}).fetch()

Template.weatherRow.helpers
  range: ->
    "#{moment(@from).format 'HH:mm'} - #{moment(@to).format 'HH:mm'}"
