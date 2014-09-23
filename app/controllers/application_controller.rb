class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception





  def update_message session
 		if session == "upload_error" 	
 			@update = "<p>There was an with video upload</p>".html_safe
 		end
  end

  
end
