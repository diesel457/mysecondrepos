server production_server, :app, :web, :primary => true

set :deploy_to, "/home/#{server_user}/www/#{application}/production"
set :branch, 'production'

namespace :deploy do

  task :stop, :on_error => :continue do
    run "forever stop /home/#{server_user}/www/#{application}/production/current/server.js"
  end

  desc 'Start again Staging server'
  task :start_staging, :on_error => :continue do
    sleep 30
    run "cd /home/#{server_user}/www/#{application}/staging/shared && ./forever_start.sh"
  end

  task :start do
    run "cp #{release_path}/config/deploy/production/forever_start.sh #{shared_path}"
    run "cd #{shared_path} && chmod a+x ./forever_start.sh && ./forever_start.sh"
    # start_staging
  end

end