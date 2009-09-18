class AddedActsAsTreeToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :parent_id, :integer
  end

  def self.down
    remove_column :albums, :parent_id
  end
end
