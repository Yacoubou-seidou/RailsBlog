class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, only: %i[new create]

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    sign_out(current_user) if user_signed_in?
    flash[:notice] = "User #{current_user.email} was logged out!" if current_user
    redirect_to root_path
  end
end
