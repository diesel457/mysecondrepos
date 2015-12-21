# Current config has multiple configurations: staging and production
# Requirements:
#   - Server access key (identity file for ssh -i) should be at :local_ssh_key_path
#   - Ruby installation through RVM

# To init the folder structure on the new server, run once:
#   - Staging:
#       cap deploy:setup
#   - Production:
#       cap production deploy:setup

# cd to project root and execute command to deploy:
#   - Staging:
#       cap deploy:update
#   - Production:
#       cap production deploy:update

# ---------------------------------------
#   Main config constants (NEED TO BE CHANGED)
# ---------------------------------------

set :application, 'app'
set :local_ssh_key_path, '~/.ssh/keys/app.pem'
set :repository, 'git@bitbucket.org:cray0000/app.git'
set :staging_server, '0.0.0.0'
set :production_server, '100.100.100.100'
set :server_user, 'ubuntu'

# ---------------------------------------
#   Rest of config (usually doesn't require changes)
# ---------------------------------------

set :stages, %w(production staging)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
require 'capistrano/deploy_lock'

set :scm, :git

default_run_options[:pty] = true

set :user, server_user

set :normalize_asset_timestamps, false
set :use_sudo, false
ssh_options[:keys] = [local_ssh_key_path]

set :keep_releases, 2

namespace :deploy do

  desc 'Stop Forever'
  task :stop, :on_error => :continue do
    run 'forever stopall'
  end

  desc 'Start Forever'
  task :start do
    run "cp #{release_path}/deploy/forever_start.sh #{shared_path}"
    run "cd #{shared_path} && chmod a+x ./forever_start.sh && ./forever_start.sh"
  end

  desc 'Restart Forever'
  task :restart do
    stop
    sleep 5
    start
  end

  desc 'Fast restart forever'
  task :fast_restart do
    run 'forever restartall'
  end

  desc 'Install node modules non-globally'
  task :npm_install do
    run "cd #{release_path} && npm install"
  end

  desc 'Run Grunt task to compile and minify assets'
  task :grunt_build do
    run "cd #{release_path} && grunt build-production"
  end

  desc 'Clean assets'
  task :grunt_clean do
    run "cd #{release_path} && grunt clean"
  end

  #desc 'Clean DB'
  #task :grunt_clean_db do
  #  run "cd #{release_path} && grunt clean-db"
  #end

  desc 'Update (Reinstall) node_modules'
  task :npm_update do
    run "cd #{release_path} && rm -rf node_modules/* && npm install"
    grunt_clean
    grunt_build
    fast_restart
  end

  desc 'Clean npm tmp directory'
  task :clean_npm_tmp do
    run "cd /home/#{server_user} && rm -rf tmp"
  end

  desc 'Link to shared upload'
  task :shared_upload do
    run "mkdir -p #{shared_path}/upload && ln -s #{shared_path}/upload #{release_path}/public/upload"
  end

  desc 'Stop staging server'
  task :stop_staging, :on_error => :continue do
  end

  desc 'Clean npm cache'
  task :npm_cache_clean do
    run "npm cache clean"
  end

  desc 'Create logs folder'
  task :logs_folder do
    run "mkdir -p #{shared_path}/log"
  end

end

after 'deploy:update_code',
      'deploy:stop_staging',
      'deploy:npm_cache_clean',
      'deploy:npm_install',
      'deploy:grunt_build',
      'deploy:shared_upload',
      'deploy:logs_folder'
after 'deploy:create_symlink', 'deploy:restart'


# if you want to clean up old releases on each deploy uncomment this:
after 'deploy:restart', 'deploy:clean_npm_tmp', 'deploy:cleanup'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end