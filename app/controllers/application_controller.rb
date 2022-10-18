class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end

  def set_locale
    I18n.locale = 'es'
  end
end
