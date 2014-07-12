class CoursesController < ApplicationController

  before_action :authenticate_user!

  
  def index
    @user = current_user
    @course = Course.all
  end

  
  def show
    @user = current_user
    @course = Course.where(id: params[:id]).first
    session[:course_id] = @course.id
  end

  
  def new
    @user = current_user
    @course = Course.new
  end

  
  def edit
  end

  
  def create
    @course_exists = Course.where(name: params[:course][:name].to_s)
    puts params[:course][:name].to_s
    if @course_exists == []
      @course = Course.new(course_params)
      if @course.save
        flash[:success] = 'Course was successfully created.'
        redirect_to users_path
      else
        render action: 'new'
      end
    else
      flash[:error] = 'Course already exists'
      redirect_to users_path  
    end
  end

  
  def update
    @user = current_user
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to users_path, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @user =current_user
    @course.destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
