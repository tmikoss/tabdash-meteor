updateNamedays = ->
  response = HTTP.get "http://apis.lv/namedays.json", params: { key: '6db54a20a8ed38e84c4e10d9eaac5cfaccd3299a' }

  @Namedays.remove({})

  for item in response.data
    @Namedays.insert
      month: item.month
      day:   item.day
      name:  item.name

SyncedCron.add
  name: 'updateNamedays'
  schedule: (parser) -> parser.recur().first().dayOfMonth()
  job: updateNamedays
