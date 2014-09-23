class Search < ActiveRecord::Base

	def videos
		@videos ||= find_videos
	end

private

	def find_videos
		videos = Video.all
	  videos = videos.where(sex: sex) if sex.present?
	  videos = videos.where("location like ?", "%#{location}%") if keywords.present?
	  videos = videos.where("keywords like ?", "%#{keywords}%") if keywords.present?
	  videos = videos.where(age: age) if age.present?
	  videos
	end

end
