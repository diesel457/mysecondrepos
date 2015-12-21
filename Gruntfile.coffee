###
  Grunt.js project configuration. Available tasks:

  grunt          - Default task for development. Watches for file updates,
                   recompiles and reloading browser.
                   !! WARNING !! If you pull changes from repository, perform
                   the 'grunt build' task once before using this task.
  grunt build    - Do full project build with DEVELOPMENT configuration

  grunt build-production - Do full project build with PRODUCTION configuration

  grunt debug    - Check for compilation errors of /src/

  grunt clean    - Clean (delete) all compiled, temporary files and
                   downloaded dependencies

  grunt clean-db - Purge project's Redis and Mongo databases

  grunt test     - Run Casper.js tests

  #-------------------------------------------------------------------------
  # [Spec] Full process of building assets ('build-production' task):
  #-------------------------------------------------------------------------

  1. bower  - Fetch client-side dependencies (defined in bower.json)
              and copy their main files defined in "exportsOverride"
              section of bower.json to /tmp/ subfolders:
                min/    - already minified files that only need to be concat'ed;
                full/   - files that need to be minified and concat'ed;
                single/ - files that will be used separatly without concat'ing
                          them into one.
  2. copy   - Copy vendor .css into .scss (to be able to plug them into main
              stylesheets). Also copy .js files from /tmp/single/ into their
              serving directory at /public/js/minified/.
  3. coffee - Compile static scripts.
  4. uglify - Minify /public/js/full/ files.
  5. concat - Concatenate all vendor .js files into one.
  6. clean  - Clean temporary files.
###

conf = null
_ = require 'lodash'
nconf = require 'nconf'
require('local-derby-server/nconf') __dirname

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    mongo: nconf.get 'MONGO_DB'
    redis: nconf.get 'REDIS_DB'

    bower:
      install:
        options:
          install: true

    coffee:
      options:
        bare: true
      app:
        expand: true
        cwd: './src/'
        src: ['**/*.coffee']
        dest: './lib/'
        ext: '.js'

    copy:
      js:
        files: [
          expand: true
          flatten: true
          src: ['./tmp/single/**']
          dest: './public/js/minified/'
          filter: 'isFile'
        ]
      bower_css:
        files: [
          expand: true
          flatten: true
          cwd: './tmp/css'
          src: ['**']
          dest: './styles/vendor/'
          filter: 'isFile'
        ]
        options: process: (content, srcpath) ->
          # Replace fonts path in ionic
          if /ionic\.css/.test(srcpath)
            content = content.replace /\.\.\/fonts\//g, '/fonts/vendor/'
          content
      fonts:
        files: [
          expand: true
          flatten: true
          cwd: './tmp/fonts'
          src: ['**']
          dest: './public/fonts/vendor'
          filter: 'isFile'
        ]

    uglify:
      options:
        report: 'min'
        preserveComments: false
      vendor_full:
        src: ['./tmp/full/**/*.js']
        dest: './tmp/full.js'
        filter: 'isFile'

    concat:
      options:
        separator: ';'
      vendor_min:
        files: [
          src: './tmp/min/**/*.js'
          dest: './tmp/min.js'
          filter: 'isFile'
          nonull: true
        ]
      vendor:
        files:
          './public/js/minified/vendor.min.js': [
            './tmp/full.js'
            './tmp/min.js'
            './public/js/vendor/google-analytics.js'
#            './public/js/vendor/jqmath-etc-0.4.0.min.js'
          ]

    clean:
      all: ['./public/js/minified/*'
            './src/const/json/*.json'
            './bower_components']
      js: ['./lib']
      tmp: ['./tmp']

    shell:
      options:
        stdout: true
      clean_redis:
        command: 'redis-cli -n <%= redis %> flushdb'
      clean_mongo:
        command: 'mongo <%= mongo %> --eval "db.dropDatabase();"'
      fontello_open:
        command: 'make fontopen'
      fontello_save:
        command: 'make fontsave'
      prices_test:
        command: './node_modules/.bin/mocha-casperjs src/games/prices/tests/'

    waitServer:
      server:
        options:
          url: 'http://localhost:<%= port %>'
          fail: ->
            console.error 'the server had not start'

    notify_hooks:
      options:
        enabled: true
        max_jshint_notifications: 5

    svg_sprite:
      main:
        expand: true
        cwd: './public/img/icons'
        src: ['**/*.svg']
        dest: './public/img/sprites'
        options:
          shape:
            id:
              generator: 'icon-%s'
          mode:
            symbol:
              dest: ''
              sprite: 'icons.svg'
              inline: true

  require('load-grunt-tasks') grunt
  grunt.task.run 'notify_hooks'

  ##############################
  ## HELPERS
  ##############################

  # --force option functionality (see http://stackoverflow.com/a/16972894)

  grunt.registerTask 'force_on'
  , 'force the force option on if needed', ->
    if not grunt.option 'force'
      grunt.config.set 'usetheforce_set', true
      grunt.option 'force', true

  grunt.registerTask 'force_off'
  , 'turn force option off if we have previously set it', ->
    if grunt.config.get 'usetheforce_set'
      grunt.option 'force', false

  ##############################
  ## TASKS
  ##############################

  grunt.registerTask 'nginx', 'Generate nginx configs', ->
    scheme = nconf.get('SCHEME') || 'http'
    if nconf.get('STAGE') is 'development'
      grunt.log.error 'Provide the STAGE environment variable (production/staging)'
      return
    if scheme is 'http'
      grunt.log.write 'Generating nginx HTTP config.\n'
      grunt.log.write 'If you want to generate an HTTPS config, specify ' +
        'the SCHEME=https environment variable.\n'
    else
      grunt.log.write 'Generating nginx HTTPS config with SSL certificate.\n'
    unless nconf.get('STAGE') is 'production'
      nconf.set 'APP', (nconf.get('APP') + '_' + nconf.get('STAGE'))
    filepath = "./tmp/nginx/#{nconf.get 'APP'}.conf"
    nginxTemplate = grunt.file.read "./config/nginx/#{scheme}.conf"
    nginxConfig =  _.template nginxTemplate, nconf.get()
    grunt.file.write filepath, nginxConfig
    grunt.log.write '\n'
    grunt.log.ok "Nginx configs for #{nconf.get 'APP'}" +
      " were generated to tmp/nginx/#{nconf.get 'APP'}"

  # Handle assets
  grunt.registerTask 'assets',
    ['bower', 'svg_sprite']

  # Build all with production configuration
  grunt.registerTask 'build-production',
    ['assets', 'clean:tmp']

  # Build all with dev configuration
  grunt.registerTask 'build',
    ['assets', 'clean:tmp']

  # Build all with staging configuration (dev config + production optimizations)
  grunt.registerTask 'build-staging',
    ['assets', 'clean:tmp']

  # Default task to run in development environment
  grunt.registerTask 'default', ['build']

  # Debug CoffeeScript compilation errors
  grunt.registerTask 'debug', ['force_on', 'coffee', 'clean:js']

  # Clean database and redis
  grunt.registerTask 'clean-db', ['shell:clean_mongo', 'shell:clean_redis']

  # Open current fontello config in browser
  grunt.registerTask 'fontello', 'Open fontello site with current config', ->
    grunt.task.run 'shell:fontello_open'
    grunt.log.write '\n'
    grunt.log.ok 'Instructions:'
    grunt.log.write """
      1. Add/edit icons on fontello's website that was just opened
      2. Click on 'Save session'
      3. Run command 'grunt fontello-save' to automatically download and
         replace the old fontello config

    """

  # Download updated fontello bundle and save it into the fonts directory
  grunt.registerTask 'fontello-save', 'Save updated fontello', ->
    grunt.task.run 'shell:fontello_save'
    grunt.task.run 'build'

  grunt.registerTask 'server', 'Start a custom web server.', ->
    process.env.STAGE = 'test'
    require('local-derby-server/nconf') __dirname
    port = nconf.get('PORT') || 3010
    grunt.log.writeln "Starting web server on port #{port}."
    require('./server.js')
    grunt.config 'port', port
    done = this.async()
    setTimeout( ->
      done()
    , 15000)
    grunt.task.run 'waitServer'


  grunt.registerTask 'prices-test', ->
    grunt.task.run ['server', 'shell:prices_test']
