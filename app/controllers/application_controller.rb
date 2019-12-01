class ApplicationController < ActionController::Base
    # パラメータ追加
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        # サインアップ時にユーザ名を使用する
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
        # その他情報を付加
        devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :profile, :blog_url])
    end
end
