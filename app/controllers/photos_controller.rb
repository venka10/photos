class PhotosController < ApplicationController

  hobo_model_controller

  auto_actions :all

  index_action :albumview, :albumviewedit
  web_method :albumviewupdate
  
  def albumviewedit
    @album = Album.find(params[:album])
    if @album
        hobo_index Photo.viewable(current_user).album_is(params[:album]), :per_page=>10
    end
  end
  
  def albumviewupdate
    @photos = params["will_paginate/collection"]
    @photos.each_pair do |id, value|
      photo = Photo.find(value[:id])
      photo.title = value[:title]
      photo.deleted = value[:deleted]
      photo.sharing_type = SharingType.find(value[:sharing_type])
      photo.save
    end
    redirect_to albumviewedit_photos_path + "?album=#{params[:id]}"
  end
  
  def albumview
    #nil.venka
    @album = Album.find(params[:album])
    if @album.owner.id = current_user.id
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
  
end
