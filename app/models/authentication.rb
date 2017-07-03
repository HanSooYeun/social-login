class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.authenticate!(omniauth)
    auth = self.find_or_create_by(provider: omniauth.provider, uid: omniauth.uid) do |auth|
    auth.registered = false
      # auth.name = omniauth.info.name
      # auth.nickname = omniauth.info.nickname
      # auth.image = omniauth.info.image
    end
  end
    def associate_with(user)
  # begin
  #   token = SecureRandom.urlsafe_base64
  # end while Authentication.exists?(registration_token: token)

  self.update_attributes(
    user_id: user.id,
    registration_token_sent_at: Time.now,
    registration_token: SecureRandom.urlsafe_base64 # token
  )
    end
    def self.register!(token, user_id)
  auth = self.find_by(registration_token: token, user_id: user_id, registered: false)
  if auth.present?
    if auth.registration_token_sent_at >= 24.hours.ago
      auth.update_attribute(:registered, true)
    else auth.registration_token_sent_at < 24.hours.ago
      auth.delete
    end
  end
      auth
    end
end
