require('derby-webpack')({
  restartTimeout: 2000,
  moduleMode: true,
  stylus: {
    import: [
      __dirname + '/app/styles/fonts.styl',
      __dirname + '/app/styles/vars.styl'
    ]
  }
});
