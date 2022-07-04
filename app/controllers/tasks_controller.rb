class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = Task.all
      @tasks = Task.order(deadline: :desc)
    else
      @tasks = Task.all
      @tasks = Task.order(created_at: :desc)
    end

    if params[:sort_priority_high]
      @tasks = Task.all
      @tasks = Task.order(priority: :asc)
    end

    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = Task.where("name LIKE ?", "%#{params[:task][:name]}%")
        @tasks = Task.where(status: params[:task][:status])
      elsif
        params[:task][:name].present?
        @tasks = Task.where("name LIKE ?", "%#{params[:task][:name]}%")
      elsif
        params[:task][:status].present?
        @tasks = Task.where(status: params[:task][:status])
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "タスクを登録しました" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "タスクを更新しました" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "本当に消していいですか？" }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :content, :deadline, :status, :priority)
    end
end
