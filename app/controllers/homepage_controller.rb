class HomepageController < ApplicationController
	def index
 
	end

  def shuffle
   project = Project.all.sample
   @image = project.images.first.url
      respond_to do |format|
        format.json { render json: project.to_json }
        format.json { render :json => @image}          
      end
  end
end
