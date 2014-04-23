require 'mixpanel-ruby'

class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :instantiate_mixpanel

  def instantiate_mixpanel
    @mixpanel = Mixpanel::Tracker.new(ENV['MIXPANEL_API_KEY'])
  end
end
