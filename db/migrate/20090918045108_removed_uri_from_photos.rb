class RemovedUriFromPhotos < ActiveRecord::Migration
  def self.up
    remove_column :photos, :uri
  end

  def self.down
    add_column :photos, :uri, :string
  end
end
