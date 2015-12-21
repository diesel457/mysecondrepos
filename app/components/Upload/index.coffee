ComponentBase = require '../../../core/componentBase'

module.exports = class Upload extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  changeInput: (e) ->
    single = @model.get 'single'
    el = e.target
    file = el.files[0]
    path = @model.get 'path'
    @model.set 'fileName', file.name
    formData = new FormData()
    xhr = new XMLHttpRequest
    formData.append 'uploadFile', file
    xhr.open "POST", '/api/upload', true
    xhr.setRequestHeader "x-file-size", file.size
    xhr.upload.addEventListener 'progress', @onProgress.bind(@), false
    xhr.send formData
    xhr.onreadystatechange = () =>
      if (xhr.readyState != 4)
        return
      if (xhr.status != 200)
        @model.del 'fileData'
        alert 'Internal server error, try again'
        @emit 'error', xhr.status, xhr.responseText
      else
        try
          data = JSON.parse xhr.responseText
          if single
            @model.set 'value', data.name
          else
            @model.push 'value', data.name

  delImg: (index) ->
    single = @model.get 'single'

    if single
      fileName = @model.get 'value'
    else
      fileName = @model.get 'value.' + index
      
    formData = new FormData()
    formData.append 'deleteFile', fileName
    xhr = new XMLHttpRequest
    xhr.open "POST", '/api/delete', true
    xhr.send formData
    xhr.onreadystatechange = () =>
      if (xhr.readyState != 4)
        return
      if (xhr.status != 200)
        @model.del 'fileData'
        alert 'Internal server error, try again'
        @emit 'error', xhr.status, xhr.responseText
      else
        try
          data = JSON.parse xhr.responseText
          if data.delete
            if single
              @model.del 'value'
            else
              @model.remove 'value', index
            @model.del 'fileName'
            @model.del 'fileData'
            @model.del 'inputValue'

  onProgress: (e) ->
    @model.set 'fileData.progress', e.loaded / e.total * 100

  getWidth: (progress)->
    return 0 unless progress
    Number(progress)
