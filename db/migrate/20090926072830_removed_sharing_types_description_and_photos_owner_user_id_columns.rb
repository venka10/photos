class RemovedSharingTypesDescriptionAndPhotosOwnerUserIdColumns < ActiveRecord::Migration
  def self.up
    remove_column :sharing_types, :description
    
    remove_column :photos, :owner_user_id
  end

  def self.down
    add_column :sharing_types, :description, :string
    
    add_column :photos, :owner_user_id, :integer
  end
end
