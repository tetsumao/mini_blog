class ApplicationController < ActionController::Base
  # Basic認証
  before_action :basic_auth, if: :production? 
  # パラメータ追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時にユーザ名を使用する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    # その他情報を付加
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :profile, :blog_url])
  end

  private

  # producition確認
  def production?
    Rails.env.production?
  end

  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
