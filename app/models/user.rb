class User < ActiveRecord::Base
	has_many :projects
  has_many :transactions
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
  		:recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  mount_uploader :avatar, AvatarUploader

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(first_name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

 def self.from_omniauth(auth)

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.name
        user.remote_avatar_url = auth.info.image.gsub('http://','https://')

      end

  end

end

