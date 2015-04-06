@Forecasts = new Mongo.Collection 'forecasts'

if Meteor.isServer
  @Forecasts._ensureIndex { to: 1 }, { expireAfterSeconds: 0 }
