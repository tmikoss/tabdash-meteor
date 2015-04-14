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

Template.carousel.onRendered = ->
  @$('.carousel').carousel
    interval: false

Template.carousel.gestures
  'swipeleft .carousel': (e, template) ->
    template.$('.carousel').carousel('next').carousel('pause')

  'swiperight .carousel': (e, template) ->
    template.$('.carousel').carousel('prev').carousel('pause')

Template.weather.helpers
  forecasts: ->
    Forecasts.find({}, { sort: { from: 1 }}).fetch()

Template.weatherRow.helpers
  formattedTime: ->
    "#{moment(@from).format 'HH:mm'} - #{moment(@to).format 'HH:mm'}"

Template.trains.helpers
  trains: ->
    Trains.find({}, { sort: { time: 1 }}).fetch()

Template.trainRow.helpers
  formattedTime: ->
    moment(@time).format 'HH:mm'
