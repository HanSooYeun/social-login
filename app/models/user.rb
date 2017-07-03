class User < ActiveRecord::Base
  def update_login_status(auth, remote_ip)
    if self.token.nil? || (self.current_sign_in_ip != remote_ip)
      begin
        token = SecureRandom.urlsafe_base64
      end while User.exists?(token: token)
    else
      token = self.token
    end

    self.update_attributes(
      last_sign_in_at: self.current_sign_in_at,
      current_sign_in_at: Time.now,
      sign_in_count: (self.sign_in_count || 0) + 1,
      last_sign_in_ip: self.current_sign_in_ip,
      current_sign_in_ip: remote_ip,
      token: token,
      # image_url: auth.image,
      # name: auth.name,
      # nickname: auth.nickname
    )
  end
end