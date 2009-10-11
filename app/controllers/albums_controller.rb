class AlbumsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def photos
  
  end
 
  show_action :more

#  def index
#    hobo_index Album.toplevel
#  end

end
