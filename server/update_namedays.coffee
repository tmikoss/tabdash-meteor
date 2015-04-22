updateNamedays = ->
  response = HTTP.get "http://apis.lv/namedays.json", params: { key: '6db54a20a8ed38e84c4e10d9eaac5cfaccd3299a' }

  TD.Namedays.remove({})

  for item in response.data
    TD.Namedays.insert
      month: item.month
      day:   item.day
      name:  item.name

  TD.ticked 'namedays'

Meteor.startup ->
  TD.onTick 'namedays', 1, 'month', updateNamedays
