class VideosController < ApplicationController
  before_action :set_video, only: [:edit, :update, :destroy]
  

  # GET /videos
  # GET /videos.json
  def index
    @search = Search.new
    if params[:page].present?
     page = params[:page]
    else
      page = 1
    end
     @video = Video.new 
     @videos = Video.all.where('created_at <= ?' , 1.hours.ago.to_datetime)
     @update = update_message session[:update]
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    respond_to do |format|               
      format.js
    end   
  end

  def search
    @video = Video.new
    @search = Search.new
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    search = Search.find(params[:id])
    @videos = search.videos.where('created_at > ?' , 1.hours.ago).page(page).per_page(5)
  end

  # GET /videos/new
  def new
    
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    begin
      video = Video.create({title: params[:title], age: params[:age], sex: params[:sex], location: params[:location], keywords: params[:keywords], video: params[:video]})
      url = video.aws_url = video.video.url
      client = YouTubeIt::Client.new(:username => ENV['USERNAME'] , :password => ENV['PASSWORD'] , :dev_key => ENV['DEVELOPER_KEY'])
      youtube_video = client.video_upload(url, title: video.title)
      youtube_url = video.youtube_url = youtube_video.media_content[0].url
      if youtube_url[/youtu\.be\/([^\?]*)/]
        video.yt_video_id = $1
      else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        video.yt_video_id = $5
      end
      video.thumbnail = youtube_video.thumbnails[1].url
      video.save
      session[:video] = nil
      flash[:notice]  = "Video uploaded successfully"
     

      render "videos/index"
  
    rescue Exception => e
      session[:update] = "upload_error"
      redirect_to root_path
    end
    # omni_request =  session[:omniauth]
    # token = omni_request["credentials"].token
    # refresh_token = omni_request["credentials"].refresh_token
    # expiration = omni_request["credentials"].expires_at
    # # client = YouTubeIt::OAuth2Client.new(client_access_token: token, client_refresh_token: refresh_token, client_id: ENV["GOOGLE_CLIENT_ID"], client_secret: ENV["GOOGLE_CLIENT_SECRET"], dev_key: ENV["DEVELOPER_KEY"], expires_at: expiration)
    # client = YouTubeIt::Client.new(:username => ENV['DEVELOPER_KEY'] , :password => ENV['DEVELOPER_KEY'] , :dev_key => ENV['DEVELOPER_KEY'])
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' } 
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  def upload
    # client = developer_key
    unless params[:title].present?
      @no_title = true
    else
      @video = Video.create({title: params[:title], age: params[:age].to_i, sex: params[:sex], location: params[:location], keywords: params[:keywords]})
        if @video
        @upload_info = Video.token_form(params, save_video_new_video_url(:video_id => @video.id))
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      client = YouTubeIt::Client.new(:username => "tonytaudesign" , :password => "getwithitx5zx5" , :dev_key => "AIzaSyBAbnuOKzE1Pa7A3thvI1GLtpVpHLEnVcs")
      y_video = client.video_by(params[:id])
      y_video_url = y_video.media_content[0].url
      @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true, :youtube_url => y_video_url  )
      Video.delete_incomplete_videos
      notice = "Video successfully uploaded"
    else
      notice = "Video did not successfully upload"
      Video.delete_video(@video)
    end
    redirect_to videos_path, :notice => notice
  end

  def upload_button
    @video = Video.new
    respond_to do |format|
      format.js
    end
  end

  def search_button
    @search = Search.new
    respond_to do |format|
      format.js
    end
  end






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:link, :title, :author, :duration, :likes, :dislikes, :age, :sex, :location, :page, :video, :file)
    end


end
