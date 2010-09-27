class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :username,                  :string, :limit => 40
      t.column :first_name,                :string, :limit => 100, :default => '', :null => true
      t.column :last_name,                 :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :status,                    :boolean, :default => false
      t.column :cached_slug,               :string, :limit => 80
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :string, :limit => 40
      t.column :reset_password_code,       :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
    end
    
    add_index :users, :username, :unique => true
    add_index :users, :cached_slug, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
