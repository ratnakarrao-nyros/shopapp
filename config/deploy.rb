#require 'capistrano/rails'
#require "rvm/capistrano"

set :application, 'shopapp'
set :repo_url, 'git@github.com:ratnakarrao-nyros/shopapp.git'


# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

#set :deploy_to, '/var/www/shopapp'
set :scm, :git
set :format, :pretty

# set :log_level, :debug
#set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :default_stage, "staging" 


set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

#set :deploy_via, :copy

set :use_sudo, true


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





# for RoR 4
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, ''
#set :bundle_without, %w{test development}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all




namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      run "#{current_path}/webctl restart #{dev_user} #{dev_port}" 
      #run "cd #{current_path} && /etc/init.d/unicorn_#{fetch :application} restart"
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  #after "deploy:start", :restart_web_server 
#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      # within release_path do
#      #   execute :rake, 'cache:clear'
#      # end
#    end
#  end

  after :finishing, 'deploy:cleanup'

end
