_ = require 'lodash'
searchFields =
  ['title', 'description', 'price', 'options.producer', 'options.type', 'options.material', 'options.form', 'options.length', 'options.width', 'options.height', 'options.capacity']
module.exports =

load: (params) ->
  search = params?.query?.search or ''
  query =
    $or: []
    $limit: 10
    
  #Search filter
  for field in searchFields
    q = {}
    if isNaN(parseFloat(search))
      q[field] =
        $regex: search
        $options: 'i'
    else
      q[field] =
        $eq: parseFloat(search) or ''

    query.$or.push q

  @query = @model.query 'cards', query
  @_subscriptions.push @query

setup: ->
  @query.refIds '_page.cardIds'
