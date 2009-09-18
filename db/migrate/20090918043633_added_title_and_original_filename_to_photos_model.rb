class AddedTitleAndOriginalFilenameToPhotosModel < ActiveRecord::Migration
  def self.up
    add_column :photos, :title, :string
    add_column :photos, :original_filename, :string
  end

  def self.down
    remove_column :photos, :title
    remove_column :photos, :original_filename
  end
end
