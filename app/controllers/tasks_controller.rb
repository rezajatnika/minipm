class TasksController < ApplicationController
  before_action :require_login
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :finish, :cancel, :destroy]

  # GET /projects/1/task/new
  def new
    @task = current_user.tasks.new(project: @project)
    authorize @task
  end

  # GET /projects/1/tasks/1
  def show
  end

  # GET /projects/1/tasks/1/edit
  def edit
    authorize @task
  end

  # POST /projects/1/tasks
  def create
    @task = current_user.tasks.build(task_params)
    @task.project = @project

    if @task.save
      redirect_to @project, info: 'Task was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to @project
  end

  # PUT /projects/1/tasks/1/finish
  def finish
    @task.update_attributes(finished: true)
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  # PUT /projects/1/tasks/1/cancel
  def cancel
    @task.update_attributes(finished: false)
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  private

  # Set task id
  def set_task
    @task = @project.tasks.find(params[:id])
  end

  # Set project id
  def set_project
    @project = Project.find_by_slug!(params[:project_id])
  end

  # Strong parameters, only allow permitted paramaters
  def task_params
    params.require(:task).permit(:title, :description, :finished, assignee_ids: [])
  end
end
