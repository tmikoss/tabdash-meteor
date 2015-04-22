Template.weather.helpers
  forecastsByDay: ->
    currentTime.get()

    groupedForecasts = _.groupBy TD.Forecasts.find({}, { sort: { from: 1 }}).fetch(), (forecast) ->
      moment(forecast.from).format TD.dateFormat

    { date: date, forecasts: forecasts } for date, forecasts of groupedForecasts


Template.weatherRow.helpers
  formattedTime: ->
    "#{moment(@from).format TD.timeFormat} - #{moment(@to).format TD.timeFormat}"
