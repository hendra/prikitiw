class CreateDefaultRoles < ActiveRecord::Migration
  def self.up
    roles = [{:name => "admin"}, {:name => "user"}]
    Role.create(roles)
  end

  def self.down
    Role.delete_all
  end
end
