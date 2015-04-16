Template.header.helpers
  formattedTime: ->
    currentTime.get().format('HH:mm')

  formattedDate: ->
    currentTime.get().format('ddd DD MMM')

  namedays: ->
    now = currentTime.get()
    Namedays.find({ month: now.month() + 1, day: now.date() }, { sort: { name: 1 }}).fetch()

Template.carousel.onRendered ->
  @$('.carousel').carousel
    interval: false

Template.carousel.gestures
  'swipeleft .carousel': (e, template) ->
    template.$('.carousel').carousel('next').carousel('pause')

  'swiperight .carousel': (e, template) ->
    template.$('.carousel').carousel('prev').carousel('pause')
