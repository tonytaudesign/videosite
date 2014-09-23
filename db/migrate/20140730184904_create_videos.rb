class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :age
      t.string :youtube_url
      t.string :youtube_user_url
      t.string :aws_url
      t.string :sex
      t.string :thumbnail
      t.string :location
      t.string :expiration
      t.string :client_access_token
      t.string :client_refresh_token
      t.string :refresh_token
      t.string :title
      t.string :description
      t.string :category
      t.string :keywords
      t.string :author
      t.string :duration
      t.string :yt_video_id
      t.string :yt_user_video_id
      t.integer :likes
      t.integer :dislikes
      t.boolean  "is_complete", :default => false
      
      t.attachment :video

      t.timestamps
    end
  end
end
