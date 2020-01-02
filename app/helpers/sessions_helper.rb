module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
  
  def require_login?
    if current_user.nil?
      redirect_to login_path
    else
      logged_in?
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
