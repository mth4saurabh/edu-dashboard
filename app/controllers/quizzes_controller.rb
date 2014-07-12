class QuizzesController < ApplicationController

before_action :authenticate_user!

  
  def index
    
    @user = current_user
    @quizzes = Quiz.where(course_id: current_course.id)

  end

  
  def show

  end

  
  def new
    @user = current_user
    @quiz = Quiz.new
  end

  
  def edit
  end

  
  def create
    @quiz_exists = Quiz.where(name: params[:quiz][:name].to_s, course_id: current_course.id)
    if @quiz_exists == []
      @quiz = Quiz.new(quiz_params)
      if @quiz.save
        @quiz.course_id = current_course[:id]
        @quiz.save!
        flash[:success] = 'Quiz was successfully created.'
        redirect_to users_path
      else
        render action: 'new'
      end
    else
      flash[:error] = 'Quiz already exists'
      redirect_to users_path  
    end
  end

  
  def update
    @user = current_user
    @quiz = Quiz.find(params[:id])
    respond_to do |format|
      if @quiz.update(quiz)
        format.html { redirect_to users_path, notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @user =current_user
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name)
    end



end