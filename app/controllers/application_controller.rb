class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  # Delegate `can?` method to the `current_ability`
  def can?(action, subject)
    current_ability.can?(action, subject)
  end
  helper_method :can?
end
