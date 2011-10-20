set :application, "belta"

set :user, 'root'

set :scm, :git
set :repository,  "git@github.com:vood/belta.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

role :web, "itixity.com"                          # Your HTTP server, Apache/etc
role :app, "itixity.com"                          # This may be the same as your `Web` server
role :db,  "itixity.com", :primary => true # This is where Rails migrations will run

set :deploy_to, 'belta'
set :deploy_via, :remote_cache

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end