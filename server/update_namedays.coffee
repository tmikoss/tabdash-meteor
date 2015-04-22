updateNamedays = ->
  response = HTTP.get "http://apis.lv/namedays.json", params: { key: '6db54a20a8ed38e84c4e10d9eaac5cfaccd3299a' }

  TD.Namedays.remove({})

  for item in response.data
    TD.Namedays.insert
      month: item.month
      day:   item.day
      name:  item.name

  TD.Config.upsert { code: 'namedays'}, $set: { updatedAt: new Date }

maybeUpdate = ->
  config = TD.Config.findOne { code: 'namedays'}

  if !config?.updatedAt || config.updatedAt < moment().subtract(1, 'month')._d
    updateNamedays()

Meteor.setInterval maybeUpdate, 1000*60*5
