class PagesController < ApplicationController

  def upload_form
  	render :layout => false
  end

  def create
  	binding.pry
  end
end
