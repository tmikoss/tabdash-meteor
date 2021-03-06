routeGroupTemplates = [
  {
    name: 'Jugla'
    priority: 1
    stop: '3130'
    routes: [
      { number: '6', kind: 'tram', direction: 'a-b' }
      { number: '3', kind: 'tram', direction: 'b-a' }
      { number: '3', kind: 'tram', direction: 'd3-a' }
    ]
  },
  {
    name: 'Pētersalas iela'
    priority: 2
    stop: '2008'
    routes: [
      { number: '1', kind: 'trol', direction: 'a-b' }
      { number: '1', kind: 'trol', direction: 'a-d1' }
    ]
  },
  {
    name: 'Centrs'
    priority: 4
    stop: '3123'
    routes: [
      { number: '6', kind: 'tram', direction: 'd5-a' }
      { number: '6', kind: 'tram', direction: 'b-a' }
      { number: '11', kind: 'tram', direction: 'd5-a' }
      { number: '11', kind: 'tram', direction: 'b-a' }
    ]
  },
  {
    name: 'Stacija'
    priority: 3
    stop: '2063'
    routes: [
      { number: '11', kind: 'trol', direction: 'b-d1_12345' }
      { number: '11', kind: 'trol', direction: 'b-a' }
      { number: '11', kind: 'trol', direction: 'b-d1' }
      { number: '18', kind: 'trol', direction: 'b-d2_67' }
      { number: '18', kind: 'trol', direction: 'b-a' }
      { number: '18', kind: 'trol', direction: 'b-d2' }
      { number: '23', kind: 'trol', direction: 'b-a' }
      { number: '23', kind: 'trol', direction: 'b-d2' }
      { number: '5', kind: 'bus', direction: 'b-a' }
      { number: '47', kind: 'bus', direction: 'b-a' }
      { number: '22', kind: 'trol', direction: 'b-a' }
      { number: '22', kind: 'trol', direction: 'b-d1' }
    ]
  }
]

updateRouteGroups = ->
  TD.RouteGroups.remove({})

  for template in routeGroupTemplates
    record =
      name:     template.name
      priority: template.priority

    record[i] = [] for i in [1..7]

    TD.Routes.find($or: template.routes).forEach (route) ->
      routeTimes = _.uniq (route.stops[template.stop] || []).map (time) ->
        time:   time
        kind:   route.kind
        number: route.number

      for day in route.days
        record[day].push time for time in routeTimes

    for i in [1..7]
      record[i] = record[i].sort (a,b) -> a.time - b.time

    TD.RouteGroups.insert record

updateRoutes = ->
  rigasSatiksmeParser.loadStops HTTP.get("http://saraksti.rigassatiksme.lv/riga/stops.txt").content

  rigasSatiksmeParser.loadRoutes HTTP.get("http://saraksti.rigassatiksme.lv/riga/routes.txt").content

  TD.Routes.remove({})

  for route in rigasSatiksmeParser.routes
    dayMap = {}

    for stop in route.stops
      for days in route.times.workdays
        dayMap[days] ||= {}
        dayMap[days][stop] ||= []
        dayMap[days][stop].push route.times.times.shift()

    for days, stops of dayMap
      TD.Routes.insert
        number:    route.num
        direction: route.direction
        kind:      route.transport
        name:      route.name
        days:      days.split('')
        stops:     stops

  updateRouteGroups()

  TD.ticked 'routes'

Meteor.startup ->
  TD.onTick 'routes', 1, 'week', updateRoutes
