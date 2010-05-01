class PhotosController < ApplicationController

  hobo_model_controller


  auto_actions :all

  index_action :albumview, :albumviewedit
    
  
  def albumviewedit
    @album = Album.find(params[:album])
    if @album
        hobo_index Photo.viewable(current_user).album_is(params[:album]), :per_page=>10
    end
  end
  
  web_method :albumviewupdate
  def albumviewupdate
    #nil.venka
    @photos = params["will_paginate/collection"]
    
    begin
      @photos.each_pair do |id, value|
        photo = Photo.find(value[:id])
        photo.album = Album.find(value[:album_id])
        photo.title = value[:title]
        photo.deleted = value[:deleted]
        photo.sharing_type = SharingType.find(value[:sharing_type_id]) if value[:sharing_type_id]
        photo.save
      end
    rescue Exception => ex
      logger.error(ex)
      ex.venka
    end
#    if params[:page]
#      p = params[:page].to_i + 1
#    else
#      p = 2
#    end
#    params[:page].venka
#    redirect_to albumviewedit_photos_path + "?album=#{params[:id]}" # &page=#{p}
  end
  
  def albumview
    #nil.venka
    @album = Album.find(params[:album])
    if @album.owner.id == current_user.id
      redirect_to albumviewedit_photos_path + "?album=#{@album.id}"
    end
    if @album
      hobo_index Photo.viewable(current_user).album_is(params[:album]), :per_page=>10
    end
  end

  show_action :show do
    hobo_show
    if @photo.album.owner.id = current_user.id
      redirect_to edit_photo_path
    end
  end
  
  show_action :show_ajax do
    hobo_show 
    if !@photo.viewable?(current_user)
      render_403
    end
  end
  
  def update
    hobo_update do
      if params[:button] =~ /next/i
        redirect_to photo_path(@photo.next(current_user)) if valid?
      elsif params[:button] =~ /previous/i
        redirect_to photo_path(@photo.previous(current_user)) if valid?
      end
    end
  end
  
  def previous?
    @photo.previous(current_user)  
  end
  
  def next?
    @photo.next(current_user)
  end
  
  show_action :img do
    begin
      p = Photo.find(params[:id])
    rescue 
      p = nil
    end
    respond_with_photo(p)
  end
  
  def respond_with_photo(model)
    logger.error(p)
    if model.nil? 
      path = "#{RAILS_ROOT}/public/images/unavailable.png"
    elsif !model.viewable?(current_user)
      path = "#{RAILS_ROOT}/public/images/unauthorized.png"
    else
      path = model.photo.path(params[:style] ? params[:style] : "original")
      if path.nil?
        path = "#{RAILS_ROOT}/public/images/unavailable.png"
      end
    end

    send_file_options = { :type => File.mime_type?(path) , :disposition=>'inline' }
    send_file(path, send_file_options)
  end
  
end
