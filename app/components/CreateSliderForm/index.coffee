ComponentBase = require '../../../core/componentBase'

module.exports = class CreateSliderForm extends ComponentBase
  view: require('./index.jade')
  style: require('./index.styl')

  init: ->
    @model.set 'slides', @model.root.getDeepCopy '_page.slider'

  createSlider: ->
    slides = @model.get 'slides'
    slider = @model.root.get 'slider'
    if slider
      for slideId, slide of slider
        @model.root.del "slider.#{slideId}", =>
          for key, slide of slides
            if slide
              @model.root.add 'slider', slide, =>
                @app.history.push '/'
            else
               @app.history.push '/'
    else
      for key, slide of slides
        if slide
          @model.root.add 'slider', slide, =>
            @app.history.push '/'

  createSlide: ->
    slider = @model.del 'obj'
    @model.push 'slides', slider

  deleteSlide: (index) ->
    fileName = @model.get "slides.#{index}.image"
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
            @model.remove 'slides', index
