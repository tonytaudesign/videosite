class SearchesController < InheritedResources::Base
	def new
		@search = Search.new
	end

	def create
		params = search_params
		@search = Search.create!(age: params[:age], sex: params[:sex], location: params[:location], keywords: params[:keywords])
		redirect_to video_path(@search.id)
	end

	def show
	  if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
		@search = Search.find(params[:id])
		@videos = @search.videos.page(page).per_page(5)
	end

	private

	def search_params
    params.permit(:age, :sex, :location, :keywords, :page)
  end
end
