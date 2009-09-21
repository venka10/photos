class MovedOwnerUserIdFromPhotoToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :owner_user_id, :integer
    
    change_column :photos, :parent_id, :integer, :default => nil, :limit => 4
  end

  def self.down
    remove_column :albums, :owner_user_id
    
    change_column :photos, :parent_id, :integer, :default => 0
  end
end
