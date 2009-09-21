class AddParentIdAndPositionColsToPhotoModel < ActiveRecord::Migration
  def self.up
    add_column :photos, :parent_id, :integer, :default=>0
    add_column :photos, :position, :integer
  end

  def self.down
    remove_column :photos, :parent_id
    remove_column :photos, :position
  end
end
