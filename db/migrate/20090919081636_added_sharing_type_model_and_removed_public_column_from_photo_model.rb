class AddedSharingTypeModelAndRemovedPublicColumnFromPhotoModel < ActiveRecord::Migration
  def self.up
    create_table :sharing_types do |t|
      t.string   :name
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    add_column :photos, :sharing_type_id, :integer
    remove_column :photos, :public
    change_column :photos, :parent_id, :integer, :default => 0
    
    SharingType.create(:name=>"Public")
    SharingType.create(:name=>"Default Share")
    SharingType.create(:name=>"Friends")
  end

  def self.down
    remove_column :photos, :sharing_type_id
    add_column :photos, :public, :boolean
    change_column :photos, :parent_id, :integer, :default => 0
    
    drop_table :sharing_types
  end
end
