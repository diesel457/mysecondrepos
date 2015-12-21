server staging_server, :app, :web, :primary => true

set :deploy_to, "/home/#{server_user}/www/#{application}/staging"
set :branch, 'master'

namespace :deploy do

  task :stop, :on_error => :continue do
    run "forever stop /home/#{server_user}/www/#{application}/staging/current/server.js"
  end

  task :start do
    run "cp #{release_path}/config/deploy/staging/forever_start.sh #{shared_path}"
    run "cd #{shared_path} && chmod a+x ./forever_start.sh && ./forever_start.sh"
  end

  task :grunt_build do
    run "cd #{release_path} && grunt build-staging"
  end

end