class CreateAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new do |u|
      u.username              = 'admin'
      u.first_name            = 'admin'
      u.last_name             = 'admin'
      u.email                 = "admin@#{AppConfig.domain_name}"
      u.password              = 'secret'
      u.password_confirmation = 'secret'
      u.status                = true
    end

    user.roles << Role.first
    user.save!
    user.activate!
  end

  def self.down
    User.delete("username = 'admin'")
  end
end
