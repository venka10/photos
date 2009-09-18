class Album < ActiveRecord::Base

  hobo_model # Don't put anything above this

  acts_as_tree
  
  fields do
    name :string
    timestamps
  end

  has_many :photos
  
  named_scope :toplevel, :conditions => "parent_id is null"
  


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
