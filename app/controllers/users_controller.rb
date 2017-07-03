class UsersController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    auth = Authentication.find(params[:auth_id])
    auth.associate_with(user)

    if Rails.env.production?
      # MailerWorker.perform_async(user.id, auth.registration_token)
      # redirect_to root_url, notice: "Email sent with registration instructions."
    else
      # do not send email, and direct forward to sessions#update
      redirect_to registration_path(user_id: user.id, token: auth.registration_token)
    end
  end

    def destroy
  if params[:user_id].to_i == current_user.id
    current_user.destroy
    session.clear
    redirect_to root_url, notice: 'Bye for now! Come back soon!'
  else
    redirect_to root_url, notice: 'You are not authorized for the job.'
  end
    end
end