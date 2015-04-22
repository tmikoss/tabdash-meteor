TD.Forecasts = new Mongo.Collection 'forecasts'

if Meteor.isServer
  TD.Forecasts._ensureIndex { to: 1 }, { expireAfterSeconds: 0 }
