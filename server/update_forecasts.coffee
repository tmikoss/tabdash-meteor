parseXml = Meteor.wrapAsync Meteor.npmRequire('xml2js').parseString

updateForecasts = ->
  response = HTTP.get "http://www.yr.no/place/Latvia/Riga/Riga/forecast_hour_by_hour.xml"

  json = parseXml response.content

  for entry in json.weatherdata.forecast[0].tabular[0].time
    dates =
      from: moment.tz(entry['$'].from, 'Europe/Riga').toDate()
      to:   moment.tz(entry['$'].to,   'Europe/Riga').toDate()

    details =
      code:        entry.symbol[0]['$'].number
      name:        entry.symbol[0]['$'].name
      temperature: entry.temperature[0]['$'].value

    TD.Forecasts.upsert dates, $set: details

  TD.Config.upsert { code: 'forecasts'}, $set: { updatedAt: new Date }

maybeUpdate = ->
  config = TD.Config.findOne { code: 'forecasts'}

  if !config?.updatedAt || config.updatedAt < moment().subtract(3, 'hours')._d
    updateForecasts()

Meteor.setInterval maybeUpdate, 1000*60*5
