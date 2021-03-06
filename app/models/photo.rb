class Photo < ActiveRecord::Base

  hobo_model # Don't put anything above this

  acts_as_ordered_tree :foreign_key => :parent_id, :order => :position

  fields do
    title :string
    filename :string
    original_filename :string
    path     :string
    deleted  :boolean
    position :integer
    timestamps
  end

  has_attached_file :photo,
    :url => '/:class/:attachment/:id/:style/:basename.:extension',
    :path => ':rails_root/pictures/:class/:attachment/:id_partition/:style/:basename.:extension'
#    ,
#    :styles => {
#      :thumb=> "150x133#",
#      :medium => "800x600#",
#      :large =>   "2560x1920#" }

  belongs_to :album
  has_many :photo_comment
  has_many :comment, :through => :photo_comment
  
  has_many :photo_tag
  has_many :tag, :through => :photo_tag
  
  has_many :photo_user
  has_many :user, :through => :photo_user
  
  # belongs_to :user, :foreign_key=>"owner_user_id"
  
  belongs_to :sharing_type
  
  named_scope :album_is, lambda{|p| {:conditions => ["albums.id = ?", "#{p}"], :include=>:album }} # this only returns photo for the album
  named_scope :top_album_is, lambda{|p| {:conditions => "albums.id in (select b.id from albums b where b.id=#{p} or b.parent_id = #{p})", :include=>:album }}
  
  named_scope :viewable, lambda{|acting_user| {:conditions=>"photos.deleted=0 and ((photos.sharing_type_id in (select id from sharing_types where name='Public') and 'true'='#{acting_user.guest?}') or ('false'='#{acting_user.guest?}' and photos.id = photo_users.photo_id and photo_users.user_id = #{acting_user.id} ) or (albums.owner_user_id=#{acting_user.id}))", :include=>[:photo_user, :album] }}
  #named_scope :siblings, lambda{|parent_id| {:conditions => "photos.parent_id=#{parent_id}" }}
  named_scope :previous_siblings, lambda{|album_id, position| {:conditions => "photos.album_id=#{album_id} and photos.position < #{position}" }} 
  named_scope :next_siblings, lambda{|album_id, position| {:conditions => "photos.album_id=#{album_id} and photos.position > #{position}" }}
  named_scope :onlyjpg, :conditions => "photos.filename like '%JPG'"
  named_scope :photo_is, lambda{|p| {:conditions => ["photos.id = ?", "#{p.id}"]}}
  
#  def is_viewable?(acting_user)
#    self.deleted=0 && ((self.sharing_type_id == SharingType.find_by_name('Public').id && acting_user.guest?) || (!acting_user.guest? && self.user.select{|x| x.user_id == acting_user.id} ) || (self.album.owner_user_id=acting_user.id))
#  end
  
  def show_uri
    "#{self.path}#{self.filename}".sub(/JPG/,'progressive.jpg')
  end
  
  def original_uri
    "#{self.path}#{self.filename}"
  end
  
  
  def thumbnail_uri
    "#{self.path}#{self.filename}".sub(/JPG/,'gif')
  end

  def viewable?(acting_user)
    !Photo.viewable(acting_user).photo_is(self).empty?
  end

  def previous(acting_user)
    list = Photo.previous_siblings(self.album_id, self.position).viewable(acting_user)
    list[0] if !list.empty?
  end
  
  def next(acting_user)
    list = Photo.next_siblings(self.album_id, self.position).viewable(acting_user)
    list[0] if !list.empty?
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
     acting_user.administrator? #  acting_user.id == self.album.owner.id
  end

  def destroy_permitted?
    false # acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
