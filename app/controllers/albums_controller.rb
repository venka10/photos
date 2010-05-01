class AlbumsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def photos
  
  end
 
  show_action :more

  def index
    hobo_index Album.toplevel
  end

  show_action :show
  def show
    hobo_show
    @album = Album.find(params[:id])
    @tags = Album.find(:all, 
    :joins=>" a left outer join photos p on a.id=p.album_id left outer join photo_tags pt on p.id=pt.photo_id left outer join tags t on pt.tag_id=t.id",
    :select=>"distinct t.id as tag_id, t.name",
    :conditions=>"t.id is not null");
    
    finder = Photo.viewable(current_user).album_is(@album.id).onlyjpg
    hobo_index finder, :per_page => 12
    
    if request.xhr?
      @isAjax=true
      hobo_ajax_response
    else
      @isAjax=false
    end
    
  end

end
