class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy ]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @projects = Project.all
  end

  def show
    @task = @project.tasks.build
  end

  def new
    @project = Project.new
  end

  def edit
  end

  
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:notice] = "Project was successfully created."
      redirect_to @project
     else
      render action: 'new'
    end
  end

  def update
      if @project.update(project_params)
      flash[:notice] = "Project was successfully updated."
      redirect_to @project
    else
      render 'edit'
    end
  end
  

  def destroy
    if @project.destroy
      redirect_to(@project, notice: 'Project was successfully destroyed.')
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
  def require_same_user
    if current_user != @project.user
      flash[:alert] = "You can only edit or delete your own projects"
        redirect_to(@project)
    end
  end
end
