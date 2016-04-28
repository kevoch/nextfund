class ActivitiesController < ApplicationController
  def activity
           @activities = PublicActivity::Activity.order("created_at desc").limit(10)
  end
end
    