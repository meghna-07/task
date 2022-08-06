class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = @project.tasks.build
  end

  def edit
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to(@task.project, notice: 'Task was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to(@task.project, notice: 'Task was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
    if @task.destroy
      redirect_to(@project, notice: 'Task was successfully destroyed.')
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id)
    end
end
