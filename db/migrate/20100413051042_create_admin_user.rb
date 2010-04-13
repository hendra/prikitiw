class CreateAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new do |u|
      u.login                 = 'admin'
      u.name                  = 'admin'
      u.email                 = 'admin@prikitiw.com'
      u.password              = 'secret'
      u.password_confirmation = 'secret'
    end

    user.save!
  end

  def self.down
    User.delete("login = 'admin'")
  end
end
