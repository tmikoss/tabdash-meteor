Template.routes.onCreated ->
  @subscribe 'routeGroups'

Template.routes.helpers
  routeGroups: -> TD.RouteGroups.find({}, { sort: { priority: 1 } })

Template.routeGroup.helpers
  nextRuns: ->
    timeNow = currentTime.get()

    weekdayToday = timeNow.weekday()
    startOfToday = timeNow.clone().startOf('day')

    minutesFromMidnightNow = timeNow.diff startOfToday, 'minutes'

    runs = []

    for record in @[if weekdayToday is 0 then 7 else weekdayToday]
      if (runs.length < 5) and record.time > minutesFromMidnightNow
        runs.push
          kind:    record.kind
          number:  record.number
          fromNow: startOfToday.clone().add(record.time, 'minutes').fromNow()

    if runs.length < 5
      startOfTomorrow = timeNow.clone().add(1, 'day').startOf('day')
      weekdayTomorrow = startOfTomorrow.weekday()

      for record in @[if weekdayTomorrow is 0 then 7 else weekdayTomorrow]
        if (runs.length < 5)
          runs.push
            kind:    record.kind
            number:  record.number
            fromNow: startOfTomorrow.clone().add(record.time, 'minutes').fromNow()

    runs
