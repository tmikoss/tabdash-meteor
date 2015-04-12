cheerio = Meteor.npmRequire 'cheerio'

stops =
  riga:      1
  salaspils: 380
  dole:      250

updateTrains = ->
  today    = moment()
  tomorrow = moment().add(1, 'day')

  for date in [today, tomorrow]
    for stopName in ['salaspils', 'dole']
      response = HTTP.get  "http://www.pv.lv/lv/vilcienu_saraksts/?stop_from=#{stops.riga}&stop_to=#{stops[stopName]}&date=#{date.format('DD.MM.YYYY')}"

      $ = cheerio.load response.content

      $('.routes-list .item .row .col-3').each (i, node) =>
        [hour, minute] = $(node).text().split ':'

        trainTime = date.clone()
        trainTime.hour(hour)
        trainTime.minute(minute)
        trainTime.second(0)
        trainTime.millisecond(0)

        fields = {}
        fields[stopName] = true

        @Trains.upsert { time: trainTime._d }, $set: fields

  @Config.upsert { code: 'trains'}, $set: { updatedAt: new Date }

Meteor.startup ->
  config = @Config.findOne { code: 'trains'}

  if !config?.updatedAt || config.updatedAt < moment().subtract(6, 'hours')._d
    updateTrains()
