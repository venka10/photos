class Photo < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string
    filename :string
    original_filename :string
    path     :string
    public   :boolean
    deleted  :boolean
    timestamps
  end

  belongs_to :album
  has_many :photo_comment
  has_many :comment, :through => :photo_comment
  
  has_many :photo_tag
  has_many :tag, :through => :photo_tag
  
  has_many :photo_user
  has_many :user, :through => :photo_user
  
  belongs_to :user, :foreign_key=>"owner_user_id"
  
  def uri
    "#{self.path}#{self.filename}"
  end
  
  def owner
     User.find(self.owner_user_id)
  end
  
  def before_create
     self.owner_user_id=acting_user.id
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
