class PhotoTag < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  
  belongs_to :photo
  belongs_to :tag
  
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
