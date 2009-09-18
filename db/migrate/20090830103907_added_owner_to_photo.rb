class AddedOwnerToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :owner_user_id, :integer
  end

  def self.down
    remove_column :photos, :owner_user_id
  end
end
