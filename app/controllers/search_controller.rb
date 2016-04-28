class SearchController < ApplicationController
	def search    
      if params[:q].nil?
        @projects = []
      else
        @projects = Project.search params[:q]
      end
     render 'search'
    end

end
