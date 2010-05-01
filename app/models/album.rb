class Album < ActiveRecord::Base

  hobo_model # Don't put anything above this

  acts_as_tree
  
  fields do
    name :string
    description :string
    timestamps
  end

  has_many :photos
  belongs_to :user, :foreign_key=>"owner_user_id"
  
  named_scope :toplevel, :conditions => "parent_id is null"
  named_scope :this_and_children, lambda { |id| { :conditions => "id in (select b.id from albums b where b.id=#{id} or b.parent_id = #{id})" }} 
  
  def viewable_photos
    
  end
  
  def show?(acting_user)
    Photo.viewable(acting_user).album_is(self.id).length > 0
  end
  
  def owner
     User.find(self.owner_user_id)
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
