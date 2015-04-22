TD.Trains = new Mongo.Collection 'trains'

if Meteor.isServer
  TD.Trains._ensureIndex { time: 1 }, { expireAfterSeconds: 0 }
