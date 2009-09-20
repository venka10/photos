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

  belongs_to :album
  has_many :photo_comment
  has_many :comment, :through => :photo_comment
  
  has_many :photo_tag
  has_many :tag, :through => :photo_tag
  
  has_many :photo_user
  has_many :user, :through => :photo_user
  
  # belongs_to :user, :foreign_key=>"owner_user_id"
  
  belongs_to :sharing_type
  
  named_scope :album_is, lambda{|p| {:conditions => ["albums.id = ?", "#{p}"], :include=>:album }}
  named_scope :viewable, lambda{|acting_user| {:conditions=>"photos.deleted=0 and ((photos.sharing_type_id in (select id from sharing_types where name='Public') and 'true'='#{acting_user.guest?}') or ('false'='#{acting_user.guest?}' and photos.id = photo_users.photo_id and photo_users.user_id = #{acting_user.id} ) or (albums.owner_user_id=#{acting_user.id}))", :include=>[:photo_user, :album] }}
  #named_scope :siblings, lambda{|parent_id| {:conditions => "photos.parent_id=#{parent_id}" }}
  named_scope :previous_siblings, lambda{|parent_id, position| {:conditions => "photos.parent_id=#{parent_id} and photos.position < #{position}" }} 
  named_scope :next_siblings, lambda{|parent_id, position| {:conditions => "photos.parent_id=#{parent_id} and photos.position > #{position}" }}
  
  def uri
    "#{self.path}#{self.filename}"
  end
  

  
  def before_create
     self.owner_user_id=acting_user.id
  end

  def previous(acting_user)
    list = Photo.previous_siblings(self.parent_id, self.position).viewable(acting_user)
    list[0] if !list.empty?
  end
  
  def next(acting_user)
    list = Photo.next_siblings(self.parent_id, self.position).viewable(acting_user)
    list[0] if !list.empty?
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
