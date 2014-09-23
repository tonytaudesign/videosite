class Video < ActiveRecord::Base
	require 'open-uri'
  require 'json'
  acts_as_commentable
  default_scope { order("created_at DESC") }
  attr_accessor :comment
  
  scope :completes,   where(:is_complete => true)
  scope :incompletes, where(:is_complete => false)
  
  has_attached_file :video

  # has_attached_file :video,
  #               :url => "#{Rails.root}/app/assets/images/:basename.:extension",
  #               :path => "#{Rails.root}/app/assets/images/videos/:id/:style/:basename.:extension"
                
  # validates_attachment_presence :video

  validates_attachment_content_type :video,
    :content_type => ['video/avi','video/3gpp','video/wmv','video/mp4','video/mpeg'],
    :message => "Sorry, right now we do not support the video type uploaded",
    :if => :is_type_of_video?

  
  def is_good?
    id = self.yt_video_id
    # url = "https://gdata.youtube.com/feeds/api/users/default/uploads/#{id}"

    if self.youtube_user_url != nil
      client = YouTubeIt::OAuth2Client.new(client_access_token: self.client_access_token, client_refresh_token: self.client_refresh_token, client_id: ENV["GOOGLE_CLIENT_ID"], client_secret: ENV["GOOGLE_CLIENT_SECRET"], dev_key: ENV["DEVELOPER_KEY"], expires_at: self.expiration)
    else 
      client = YouTubeIt::Client.new(:username => ENV['USERNAME'] , :password => ENV['PASSWORD'] , :dev_key => ENV['DEVELOPER_KEY'])
      # client.video_by(id)
    end
    
  end

  def create_comment(comment)
    begin
      comments.create(:comment => comment)
      Video.yt_session.add_comment(yt_video_id, comment)
    rescue
      false
    end
  end
  
    
  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:username => ENV['USERNAME'] , :password => ENV['PASSWORD'] , :dev_key => ENV['DEVELOPER_KEY'])    
  end

  def self.delete_video(video)
    yt_session.video_delete(video.yt_video_id)
    video.destroy
      rescue
        video.destroy
  end

  def self.update_video(video, params)
    yt_session.video_update(video.yt_video_id, video_options(params))
    video.update_attributes(params)
  end

  def self.token_form(params, nexturl)
    yt_session.upload_token(video_options(params), nexturl)
  end

  def self.delete_incomplete_videos
    self.incompletes.map{|r| r.destroy}
  end

  private
    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end

    def is_type_of_video?
      video.content_type =~ %r(video)
    end

    

end
