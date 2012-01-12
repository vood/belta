class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_back notice
    redirect_to :back, notice
  rescue ActionController::RedirectBackError
    redirect_to root_path, notice
  end

end
