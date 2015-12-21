conf = require 'nconf'
async = require 'async'
utils = require './utils'

module.exports = (store) ->

  store.hook 'create', 'cards', (cardId, cards, session, backend) ->

    model = store.createModel()
    $card = model.at 'cards.' + cardId
    model.fetch $card, ->
      $card.set 'createdAt', +new Date()



  store.hook 'create', 'auths', (authId, auths, session, backend) ->
    console.log authId


  # isSuperAdmin = (userId, next) ->
  #   model = store.createModel()
  #   $user = model.at "auths.#{userId}"
  #   model.fetch $user, ->
  #     user = $user.get()
  #     if utils.isSuperAdmin user
  #       next()
  #     else
  #       next 'Permission denied (super admin hook)'
  #     model.destroy()
  #
  # store.shareClient.use 'submit', (shareRequest, done) ->
  #   opData = shareRequest.opData
  #   collection = shareRequest.collection
  #   docId = shareRequest.docName
  #   userId = shareRequest.agent.connectSession?.userId
  #   isServer = shareRequest.agent.stream.isServer
  #
  #   # allow mutate only limited collections
  #   if collection not in ['auths', 'users', 'ads', 'events', 'payments', 'members', 'tickets', 'interests', 'comments', 'derby_invites', 'votes']
  #     return done 'Denied to mutate docs in collection ' + collection
  #
  #   # allow all ops from server
  #   if isServer
  #     return done()
  #
  #   if not userId
  #     return done 'Denied notauth'
  #
  #   if collection is 'users'
  #     if userId is docId
  #       async.eachSeries opData.op, (op, next) ->
  #         if (op.p[0] is 'isAdmin' or op.p[0] is 'isSuperAdmin') and (op.oi isnt undefined || op.od isnt undefined)
  #           isSuperAdmin userId, next
  #         else
  #           next()
  #       , done
  #       return
  #     else
  #       return isSuperAdmin userId, done
  #
  #   if collection in ['ads', 'events']
  #     async.eachSeries opData.op, (op, next) ->
  #       if op.create
  #         next()
  #       else
  #         # TODO: close access for editing ads and events
  #         next()
  #     , done
  #     return
  #
  #   # TODO: limit access
  #   if collection in ['payments', 'members', 'tickets', 'interests', 'comments', 'votes']
  #     return done()
  #
  # ##############################################################################
  # #################################  FORUM HOOKS  ##############################
  # ##############################################################################
  #
  # request = require 'superagent'
  #
  # # join/leave administrators group
  # store.hook 'change', 'service.adminIds.*', (index, value, op, session)->
  #   forumUrl = conf.get 'FORUM_URL'
  #
  #   return unless op.ld or op.li
  #
  #   userId = op.li || op.ld
  #
  #   url = forumUrl + if op.li
  #     "/api/joinGroup"
  #   else
  #     "/api/leaveGroup"
  #
  #   request.post(url).send({userId, group: "administrators"}).end()
  #
  # store.hook 'change', 'auths.*.avatar', (userId, avatar) ->
  #   forumUrl = conf.get 'FORUM_URL'
  #
  #   url = forumUrl + "/api/changeAvatar"
  #
  #   if avatar.indexOf("http") isnt 0
  #     avatar = conf.get('BASE_URL') + avatar
  #
  #   request.post(url).send({userId, avatar}).end()
  #
  # store.hook 'create', 'auths', (userId, user, session, backend) ->
  #   forumUrl = conf.get 'FORUM_URL'
  #   admins = conf.get 'ADMINS'
  #   model = store.createModel()
  #
  #   email = user.emails?[0]
  #
  #   $user = model.at 'auths.' + userId
  #   model.fetch $user, ->
  #     if email and email in admins
  #       $user.set 'isSuperAdmin', true
  #
  #   # when
  #   name = (user.firstName || '') + ' ' + (user.lastName || '').trim()
  #
  #   avatar = user.avatar
  #
  #   if avatar.indexOf("http") isnt 0
  #     avatar = conf.get('BASE_URL') + avatar
  #
  #   profile =
  #     id: userId
  #     name: name.replace(/[^'"\s\-.*0-9\u00BF-\u1FFF\u2C00-\uD7FF\w]/g, '')
  #     email: email
  #     avatar: avatar if avatar
  #
  #   if email
  #     request.post(forumUrl + '/api/createUser').send(profile).end()
  #
  # store.hook 'create', 'events', (eventId, event, session, backend) ->
  #
  #   model = store.createModel()
  #   $event = model.at 'events.' + eventId
  #   model.fetch $event, ->
  #     $event.set 'createdAt', +new Date()
  #
  # store.hook 'create', 'ads', (adId, ad, session, backend) ->
  #
  #   model = store.createModel()
  #   $ad = model.at 'ads.' + adId
  #   model.fetch $ad, ->
  #     $ad.set 'createdAt', +new Date()
