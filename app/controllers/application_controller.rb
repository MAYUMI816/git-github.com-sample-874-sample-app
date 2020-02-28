class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_path
      end
    end
    
    def correct_user
      redirect_to(root_url) unless @user == current_user
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
      flash[:danger] = "管理者権限がありません。"
    end
    
    def admin_or_current_user
      #@user = User.find(params[:id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
end 