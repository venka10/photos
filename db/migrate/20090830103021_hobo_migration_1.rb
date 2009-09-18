class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :group_id
    end
    
    create_table :photo_comments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :photo_id
      t.integer  :comment_id
    end
    
    create_table :user_users do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    
    create_table :groups do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :comments do |t|
      t.text     :comment
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :tags do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :albums do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    create_table :photos do |t|
      t.string   :filename
      t.string   :uri
      t.boolean  :public
      t.boolean  :deleted
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :album_id
    end
    
    create_table :photo_tags do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :photo_id
      t.integer  :tag_id
    end
    
    create_table :photo_albums do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :album_id
      t.integer  :photo_id
    end
    
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    
    create_table :photo_users do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :photo_id
      t.integer  :user_id
    end
  end

  def self.down
    drop_table :user_groups
    drop_table :photo_comments
    drop_table :user_users
    drop_table :groups
    drop_table :comments
    drop_table :tags
    drop_table :albums
    drop_table :photos
    drop_table :photo_tags
    drop_table :photo_albums
    drop_table :users
    drop_table :photo_users
  end
end
