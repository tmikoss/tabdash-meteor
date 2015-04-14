Template.trains.helpers
  trains: ->
    Trains.find({}, { sort: { time: 1 }}).fetch()

Template.trainRow.helpers
  formattedTime: ->
    moment(@time).format 'HH:mm'
