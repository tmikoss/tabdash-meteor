Template.header.helpers
  formattedTime: ->
    currentTime.get().format(TD.timeFormat)

  formattedDate: ->
    currentTime.get().format(TD.dateFormat)

  namedays: ->
    now = currentTime.get()
    TD.Namedays.find({ month: now.month() + 1, day: now.date() }, { sort: { name: 1 }}).fetch()

Template.carousel.onRendered ->
  @$('.carousel').carousel
    interval: false

Template.carousel.events
  'click .left': (e, template) ->
    template.$('.carousel').carousel('prev').carousel('pause')

  'click .right': (e, template) ->
    template.$('.carousel').carousel('next').carousel('pause')


Template.carousel.gestures
  'swipeleft .carousel': (e, template) ->
    template.$('.carousel').carousel('next').carousel('pause')

  'swiperight .carousel': (e, template) ->
    template.$('.carousel').carousel('prev').carousel('pause')
