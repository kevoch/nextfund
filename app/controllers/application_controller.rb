class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :activity
  protect_from_forgery with: :exception
  include PublicActivity::StoreController



  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to :back  
  end

  def activity
 
           @activities = PublicActivity::Activity.order("created_at desc").limit(20)
  end

      
end
