class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: %i[new create]
  def create
    user = User.new(sign_up_params)
    if user.save
      redirect_to root_path
    else
      flash.now[:alert] = 'User not created, please try again.'
      render :new
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
