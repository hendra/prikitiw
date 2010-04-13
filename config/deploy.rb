abort "needs capistrano 2" unless respond_to?(:namespace)

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
set :application, "prikitiw"  # CHANGE THIS LINE TO USE YOUR WEBSITE'S NAME
set :repository,  "git@github.com:nicholash3ndra/prikitiw.git"  # CHANGE THIS LINE TO USE YOUR SVN REPO

# =============================================================================
# ROLES
# =============================================================================
role :web, "prikitiw.41studio.com"  # CHANGE THESE LINES TO USE YOUR OCS SERVER NAME
role :app, "prikitiw.41studio.com"
role :db,  "41studio.com", :primary => true

# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
set :user, "studioco"
set :scm, :git
set :scm_username, "hendra"

set :scm_passphrase,  Proc.new { Capistrano::CLI.password_prompt('Git Password: ') }

set :runner, "hendra"
set :use_sudo, false
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :deploy_to, "/home/#{user}/rails_apps/#{application}"
set :rails_env, 'staging'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


# =============================================================================
# TASKS
# =============================================================================
namespace :deploy do

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "ln -s /home/studioco/rails_apps/#{application}/shared/config/database.yml #{current_path}/config/database.yml"
    run "cd #{current_path} && rake db:migrate"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end
