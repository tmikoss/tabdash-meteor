updateRoutes = ->
    rigasSatiksmeParser.loadStops HTTP.get("http://saraksti.rigassatiksme.lv/riga/stops.txt").content

    rigasSatiksmeParser.loadRoutes HTTP.get("http://saraksti.rigassatiksme.lv/riga/routes.txt").content

    @Routes.remove({})

    for route in rigasSatiksmeParser.routes
      dayMap = {}

      for stop in route.stops
        for days in route.times.workdays
          dayMap[days] ||= {}
          dayMap[days][stop] ||= []
          dayMap[days][stop].push route.times.times.shift()

      for days, stops of dayMap
        @Routes.insert
          number:    route.num
          direction: route.direction
          kind:      route.transport
          name:      route.name
          days:      days.split('')
          stops:     stops

  @Config.upsert { code: 'routes' }, $set: { updatedAt: new Date }

Meteor.startup ->
  config = @Config.findOne { code: 'routes'}

  if !config?.updatedAt || config.updatedAt < moment().subtract(1, 'week')._d
    updateRoutes()
