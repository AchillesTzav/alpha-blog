class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  add_flash_types :warning, :info
  # this makes the followin methods availiable to the application helper
  # so that we can use to to views
  # if we register them only on application helper the controller will no have access to these methods
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # "!!"-> turns what comes nextg to boolean
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:warning] = "You must be longged in to perform that action"
      redirect_to login_path
    end
  end
end
