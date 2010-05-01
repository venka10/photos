class FrontController < ApplicationController

  hobo_controller

  def index
    #redirect_to albums_path  
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end
  
  def about
    
  end

  def contact
    
  end
end
