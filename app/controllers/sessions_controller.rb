class SessionsController < ApplicationController
# 第６章セッション（Session）半永続的ユーザーのIDを保持　接続をユーザーのWebブラウザ、Railsサーバーなど別途設定します。  
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました。' # https://pg-happy.jp/rails-flash-message.html
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
