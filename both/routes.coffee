@Routes = new Mongo.Collection 'routes'

@RouteGroups = [
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
    name: 'Mežaparks'
    priority: 3
    stop: '3130'
    routes: [
      { number: '11', kind: 'tram', direction: 'a-b' }
      { number: '11', kind: 'tram', direction: 'a-d5' }
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
    priority: 2
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
