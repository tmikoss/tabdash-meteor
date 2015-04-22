cheerio = Meteor.npmRequire 'cheerio'

stops =
  riga:      1
  salaspils: 380
  dole:      250

updateTrains = ->
  today    = moment().tz('Europe/Riga').startOf 'day'
  tomorrow = today.add(1, 'day')

  for date in [today, tomorrow]
    for stopName in ['salaspils', 'dole']
      response = HTTP.get  "http://www.pv.lv/lv/vilcienu_saraksts/?stop_from=#{stops.riga}&stop_to=#{stops[stopName]}&date=#{date.format('DD.MM.YYYY')}"

      $ = cheerio.load response.content

      $('.routes-list .item .row .col-3').each (i, node) =>
        [hour, minute] = $(node).text().split ':'

        trainTime = date.clone()
        trainTime.hour(hour)
        trainTime.minute(minute)

        fields = {}
        fields[stopName] = true

        TD.Trains.upsert { time: trainTime.toDate() }, $set: fields

  TD.Config.upsert { code: 'trains'}, $set: { updatedAt: new Date }

maybeUpdate = ->
  config = TD.Config.findOne { code: 'trains'}

  if !config?.updatedAt || config.updatedAt < moment().subtract(6, 'hours')._d
    updateTrains()

Meteor.setInterval maybeUpdate, 1000*60*5
