Template.header.onCreated ->
  @autorun ->
    now = currentTime.get()
    @subscribe ['namedays', now.month() + 1, now.date()]

Template.header.helpers
  formattedTime: ->
    currentTime.get().format(TD.timeFormat)

  formattedDate: ->
    currentTime.get().format(TD.dateFormat)

  namedays: ->
    TD.Namedays.find {}, { sort: { name: 1 }}

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
