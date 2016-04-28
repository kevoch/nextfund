class Project < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }

	belongs_to :user
	has_many :transactions
	# has_many :users, through: :transactions
	mount_uploaders :images, ImagesUploader
	mount_uploader :video, VideoUploader
	acts_as_votable

	searchkick
end
