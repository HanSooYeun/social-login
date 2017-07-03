class SessionsController < ApplicationController
  def create
    # raise env["omniauth.auth"].to_yaml
    # env["omniauth.auth"] = {uid: 'xxx', provider: 'xxx', extra: {}, info: {image: 'xxx', email: 'xxx', name: 'xxx'} }

    @auth = Authentication.authenticate!(env['omniauth.auth'])
    if @auth.registered?
      authenticated_user = @auth.user
      authenticated_user.update_login_status(@auth, request.remote_ip)
      session[:user_token] = authenticated_user.token
      redirect_to root_path, notice: "Welcome!!!"
    else
      render 'new'
    end
  end

  def update
    if Authentication.register!(params[:token], params[:user_id])
      redirect_to root_url, notice: "Thank you for registering. Please sign in to continue."
    else
      redirect_to root_url, notice: "Registration has expired"
    end
  end  
  
  def destroy
  session.clear # session[:user_token] = nil
  redirect_to root_url, notice: 'Bye for now. Come back soon.'
  end
end