Meteor.publish 'forecasts', ->
  TD.Forecasts.find()

Meteor.publish 'routeGroups', ->
  TD.RouteGroups.find()

Meteor.publish 'namedays', (month, day) ->
  TD.Namedays.find(month: month, day: day)
