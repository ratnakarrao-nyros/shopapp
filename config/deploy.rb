#require 'capistrano/rails'
#require "rvm/capistrano"


$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) 


set :rvm_ruby_version, '1.9.3-p448@cap'
set :rvm_type, :user



set :application, 'shopapp'
set :repo_url, 'git@github.com:ratnakarrao-nyros/shopapp.git'
set :branch, "master"

#set :deploy_to, '/var/www/shopapp'
set :scm, :git
set :format, :pretty




set :default_stage, "staging" 


set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

#set :deploy_via, :copy

set :use_sudo, false


#server '10.90.90.120', user: 'nyros', roles: %w{web app}
#role :db,  "10.90.90.120", :primary => true

#namespace :deploy do

#  desc 'Restart application'
#  task :restart do
#    on roles(:app), in: :sequence, wait: 5 do
#      # Your restart mechanism here, for example:
#      # execute :touch, release_path.join('tmp/restart.txt')
#    end
#  end

#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      # within release_path do
#      #   execute :rake, 'cache:clear'
#      # end
#    end
#  end

#  #after :finishing, 'deploy:cleanup'

#end


#set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, ''
#set :bundle_without, %w{test development}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all




namespace :deploy do
  desc "Start the Thin processes"
  task :start do
    run  <<-CMD
      cd /var/www/shopapp/current; bundle exec thin start 
    CMD
  end

  desc "Stop the Thin processes"
  task :stop do
    run <<-CMD
      cd /var/www/shopapp/current; bundle exec thin stop 
    CMD
  end

  desc "Restart the Thin processes"
  task :restart do
    run <<-CMD
      cd /var/www/shopapp/current; bundle exec thin restart 
    CMD
  end

  desc "Create a symlink from the public/cvs folder to the shared/system/cvs folder"
  task :update_cv_assets, :except => {:no_release => true} do
    run <<-CMD
      ln -s /var/www/shared/cvs /var/www/shopapp/current/public
    CMD
  end
end
















#namespace :deploy do

#  desc 'Restart application'
##  task :restart do
##    on roles(:web), in: :sequence, wait: 5 do
##      # Your restart mechanism here, for example:
##      run "#{current_path}/webctl restart #{dev_user} #{dev_port}" 
##      #run "cd #{current_path} && /etc/init.d/unicorn_#{fetch :application} restart"
##      # execute :touch, release_path.join('tmp/restart.txt')
##    end
##  end







##after "deploy:start", :restart_web_server 
##  after :restart, :clear_cache do
##    on roles(:web), in: :groups, limit: 3, wait: 10 do
##      # Here we can do anything such as:
##      # within release_path do
##      #   execute :rake, 'cache:clear'
##      # end
##    end
##  end


#  after :finishing, 'deploy:cleanup'

#end
