class AddRegistrationTokenToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :registration_token, :string
    add_column :authentications, :registration_token_sent_at, :datetime
  end
end
