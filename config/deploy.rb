require "bundler/capistrano"

server "ec2-54-218-231-87.us-west-2.compute.amazonaws.com", :web, :app, :db, primary: true
set :application, "spree-tester"
set :user, "bitnami"
set :deploy_to, "/opt/#{user}/projects/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:koryteg/spree-tester.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "meetearl")]

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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