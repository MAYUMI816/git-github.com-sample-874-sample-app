class TasksController < ApplicationController
  before_action :set_user #Controllerで使う同じコードはbefore_actionでまとめてしまえばいい。
  before_action :set_task, only: %i(show edit update destroy)
  
  
  
  def index #* index（一覧画面）
   # @task = Task.find(params[:user_id])
    @task = @user.tasks.all
    #@task = @user.tasks
  end
  
  def show #* show（特定の投稿を表示する画面) 詳細ページ
    @task = Task.find(params[:id])
  end
  
  def new #* new（投稿の新規作成画面）
     #@task = @user.tasks.new(task_params)
    @task = Task.new
  end
  


  def create #* C6 create（投稿の新規保存）3. 9. 2　入力フォームの送信先を指定しよう
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。" #success（緑：データ保存の成功など）
      redirect_to user_tasks_url @user   #コントローラーのアクション内で自動的にページに切り替えるためのメソッド
    else
      render :new
    end
  end




  
  def edit #* edit（投稿の編集画面）
    @task = Task.find(params[:id])
    @user = User.find(session[:user_id])
  end
  
  def update #* update（投稿の更新保存）
     if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
     else
      render :edit
     end
  end   
    #@task = Task.find(params[:id])
    #flash[:success] = "タスクを更新しました。"
    #@task.save
    #redirect_to user_task_url @user
 

  
#  def destroy #* destroy（投稿の削除）
#    @task.destroy
#    flash[:success] = "タスクを削除しました。"
#    redirect_to user_tasks_url @user #管理者のタスク一覧(user_tasks GET    /users/:user_id/tasks(.:format)          tasks#index)
#  end
  
  private

      def task_params
       params.require(:task).permit(:task_name, :task_detail, :user_id)
       #params.require(:task).permit(:title,:note,:user_id)
      end
  
      def set_user
        @user = User.find(params[:user_id])
      end
      
      def set_task
        unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url @user
        end
      end
      
end  