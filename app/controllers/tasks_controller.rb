class TasksController < ApplicationController
  before_action :set_user #Controllerで使う同じコードはbefore_actionでまとめてしまえばいい。
  before_action :set_task, only: %i(show edit destroy)
  
  
  
  def index #* index（一覧画面）
    @user = User.find(params[:user_id])
    @task = @user.tasks.all
    #@task = @user.tasks
  end
  
  def new #* new（投稿の新規作成画面）
    @task = Task.new
  end
  


  def create #* create（投稿の新規保存）
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user   #コントローラーのアクション内で自動的にページに切り替えるためのメソッド
    else
      render :new
    end
  end
  




  def show #* show（特定の投稿を表示する画面) 詳細ページ
    @task = Task.find(params[:id])
  end
  
  def edit #* edit（投稿の編集画面）
    @task = Task.find(params[:id])
    @user = User.find(session[:user_id])
  end
  
  def update # update（投稿の更新保存）
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      flash[:danger] = "タスクを失敗しました。"
    end
      redirect_to user_task_url(@user,@task)
  end
  
  def destroy #* destroy（投稿の削除）
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user #管理者のタスク一覧(user_tasks GET    /users/:user_id/tasks(.:format)          tasks#index)
  end
  
  private

      def task_params
       params.require(:task).permit(:name, :description)
      end
      
      def edit_task_params
        params.require(:task).permit(:name, :description)
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