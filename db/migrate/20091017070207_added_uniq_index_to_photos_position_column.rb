class AddedUniqIndexToPhotosPositionColumn < ActiveRecord::Migration
  def self.up
    execute("ALTER TABLE photos.photos ADD UNIQUE INDEX photos_position_unique_idx (position)")
  end

  def self.down
    execute("ALTER TABLE photos.photos DROP INDEX photos_position_unique_idx")
  end
end
