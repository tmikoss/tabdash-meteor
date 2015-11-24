callbacks = []

TD.ticked = (code) ->
  TD.Config.upsert { code: code }, $set: { updatedAt: new Date }

TD.onTick = (code, amount, unit, callback) ->
  callbacks.push ->
    config = TD.Config.findOne { code: code }

    callback() if !config?.updatedAt || config.updatedAt < moment().subtract(amount, unit)._d

runCallbacks = -> callback() for callback in callbacks

Meteor.setInterval runCallbacks, 1000*60*10

runCallbacks()
