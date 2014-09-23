class AuthenticationsController < ApplicationController
  
  require 'faraday'

  def google
  end

  def create
  	omni_request = request.env["omniauth.auth"]
    session[:omniauth] = omni_request.except('extra')
  	video.client_access_token =  token = omni_request["credentials"].token
  	video.client_refresh_token = refresh_token = omni_request["credentials"].refresh_token
  	video.expiration = expiration = omni_request["credentials"].expires_at
  	client = YouTubeIt::OAuth2Client.new(client_access_token: token, client_refresh_token: refresh_token, client_id: ENV["GOOGLE_CLIENT_ID"], client_secret: ENV["GOOGLE_CLIENT_SECRET"], dev_key: ENV["DEVELOPER_KEY"], expires_at: expiration)
  	unless session[:video] == nil
      video = Video.find(session[:video])
      youtube_video = client.video_upload(video.aws_url, :title => video.title)
      youtube_url = video.youtube_user_url = youtube_video.media_content[0].url
      if youtube_url[/youtu\.be\/([^\?]*)/]
        video.yt_user_video_id = $1
      else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        video.yt_user_video_id = $5
      end
      video.save
    end
    redirect_to root_path
  end
end

