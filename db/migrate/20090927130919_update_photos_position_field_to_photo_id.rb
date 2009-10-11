class UpdatePhotosPositionFieldToPhotoId < ActiveRecord::Migration
  def self.up
    execute "update photos set position = id"
  end

  def self.down
    
  end
end
