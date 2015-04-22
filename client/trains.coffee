Template.trains.helpers
  trains: ->
    TD.Trains.find({}, { sort: { time: 1 }})

Template.trainRow.helpers
  formattedTime: ->
    moment(@time).format 'HH:mm'
