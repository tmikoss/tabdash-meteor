Template.weather.helpers
  forecasts: ->
    TD.Forecasts.find({}, { sort: { from: 1 }})

Template.weatherRow.helpers
  formattedTime: ->
    "#{moment(@from).format 'HH:mm'} - #{moment(@to).format 'HH:mm'}"
