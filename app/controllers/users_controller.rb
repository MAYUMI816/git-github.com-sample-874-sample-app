class UsersController < ApplicationController
# before_actionとはアクション実行前に実行されるメソッド。
# onlyオプションを指定すると、指定したアクションでのみ利用する。 

before_action :set_user,only: [:show, :edit, :update, :destroy] #@user = User.find(params[:id])をまとめて記述しなくて済むよう@userをセットする
before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy] #E1 8. 2. 1 ユーザーにログインを要求(  )のアクションが実行される直前にlogged_in_userメソッドが実行される
before_action :correct_user, only: [:edit, :update]  #E4 8. 2. 2 正しいユーザーであることを要求
before_action :admin_user, only: :destroy 
# set_userフィルター、logged_in_userフィルターにdestroyアクションを指定。
# 更に管理者のみ セキュリティ上万全にadmin_user,
 


  def index #利用者一覧ページ
    #@users = User.all #インスタンス変数名は全てのユーザーを代入した複数形(s)
    #@users = User.paginate(page: params[:page]) #8.4.2パラメータに基づき、データベースからひとかたまりのデータを取得
   @users = User.paginate(page: params[:page], per_page: 20) #る@usersに代入しているUser.allを、ページネーションを判定できるオブジェクトに置き換える
  end
  
  def new
    @user = User.new
    
  end
  
  def show
    #@user = User.find(params[:id]) #before_action :set_userの為削除
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
    #@user = User.find(params[:id]) #before_action :set_userの為削除
  end

  def update
    #@user = User.find(params[:id]) #before_action :set_userの為削除
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else # 更新に成功した場合の処理を記述
      render :edit      
    end
  end


  def destroy #「削除」ボタンが動作するためには、dastroyアクション
    #@user = User.find(params[:id]) #before_action :set_userの為削除
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

    # E1 8.2.1 ログイン済みのユーザーか確認
    def logged_in_user
      unless logged_in? #unlessは条件式がfalseの場合のみ記述した処理が実行される構文
      #store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
# E4 8. 2. 2 正しいユーザーであることを要求    
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