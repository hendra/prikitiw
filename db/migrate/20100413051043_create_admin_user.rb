class CreateAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new do |u|
      u.login                 = 'admin'
      u.first_name            = 'admin'
      u.last_name             = 'admin'
      u.email                 = "admin@#{AppConfig.domain_name}"
      u.password              = 'secret'
      u.password_confirmation = 'secret'
      u.state                 = 'active'
    end

    user.roles << Role.first
    user.save!
  end

  def self.down
    User.delete("login = 'admin'")
  end
end
