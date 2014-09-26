class PagesController < ApplicationController

  def upload_form
  	render :layout => false
  	@video = Video.new
  end

  def create
  	binding.pry
  end
end
