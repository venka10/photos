class ScriptToInitPaperclipForPhotos < ActiveRecord::Migration
  def self.up
    Photo.all.each do |p|
      begin
        p.photo = File.new(RAILS_ROOT + p.path + "\\" + p.filename)
        p.photo.save
        p.save
      rescue Exception => ex
        # do nothing
      end
    end
    #remove_column :photos, :photo_file_name
  end

  def self.down
    #add_column :photos, :photo_file_name, :string
  end
end
