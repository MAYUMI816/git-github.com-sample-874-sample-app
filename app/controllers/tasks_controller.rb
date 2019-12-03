class TasksController < ApplicationController
  before_action :set_user #Controllerで使う同じコードはbefore_actionでまとめてしまえばいい。
  before_action :set_task, only: %i(show edit update destroy)
  
  
  
  def index
    @user = User.find(params[:user_id])
    @task = @user.tasks.all
    #@task = @user.tasks
  end
  
  def new
    @task = Task.new
  end
  


  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user   #コントローラーのアクション内で自動的にページに切り替えるためのメソッド
    else
      render :new
    end
  end



  def show
  end
  
  def edit  
  end
  
  def update

      
  end
  
  def destroy
  end
  
  private

      def task_params
      params.require(:task).permit(:task_name, :task_detail, :user_id)
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