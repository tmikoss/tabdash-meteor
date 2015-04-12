@Trains = new Mongo.Collection 'trains'

if Meteor.isServer
  @Trains._ensureIndex { time: 1 }, { expireAfterSeconds: 0 }
