class UsersController < ApplicationController
before_action :logged_in_user, only: [:show, :edit, :update,:destroy] # #ログイン済み
before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
before_action :correct_user, only: [:edit, :update] ##正しいユーザーのみ
before_action :admin_user, only: :destroy #管理者のみ
# before_actionとはアクション実行前に実行されるメソッド。
# onlyオプションを指定すると、指定したアクションでのみ利用する。  


  def index #利用者一覧ページ
    #@users = User.all #インスタンス変数名は全てのユーザーを代入した複数形(s)
    #@users = User.paginate(page: params[:page]) #8.4.2パラメータに基づき、データベースからひとかたまりのデータを取得
   @users = User.paginate(page: params[:page]) #る@usersに代入しているUser.allを、ページネーションを判定できるオブジェクトに置き換える
  end
  
  def new
    @user = User.new
    
  end
  
  def show
    @user = User.find(params[:id])
  end



  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ユーザーの新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else # 更新に成功した場合の処理を記述
      render :edit      
    end
  end


  def destroy #「削除」ボタンが動作するためには、dastroyアクション
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

# beforeフィルター
# paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
      store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
# アクセスしたユーザーが現在ログインしているユーザーか確認    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
     # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end