Template.trains.helpers
  trainsByDay: ->
    currentTime.get()

    groupedTrains = _.groupBy TD.Trains.find({}, { sort: { time: 1 }}).fetch(), (train) ->
      moment(train.time).format TD.dateFormat

    { date: date, trains: trains } for date, trains of groupedTrains

Template.trainRow.helpers
  formattedTime: ->
    moment(@time).format TD.timeFormat
