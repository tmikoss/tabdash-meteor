Template.weather.helpers
  forecasts: ->
    Forecasts.find({}, { sort: { from: 1 }}).fetch()

Template.weatherRow.helpers
  formattedTime: ->
    "#{moment(@from).format 'HH:mm'} - #{moment(@to).format 'HH:mm'}"
