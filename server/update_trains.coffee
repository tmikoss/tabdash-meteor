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

        @Trains.upsert { time: trainTime.toDate() }, $set: fields

SyncedCron.add
  name: 'updateTrains'
  schedule: (parser) -> parser.recur().on(1).hour()
  job: updateTrains
