class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = current_user.exams
  end

  def new
    @exam = current_user.exams.new
    @exam.questions.build
  end

  def create
    @exam = current_user.exams.new(exam_params)
    if @exam.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'new'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @exam.update(exam_params)
      flash[:notice] = "Successfully updated"
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_to edit_exam_url(@exam)
  end

  def destroy
    @exam.destroy
    redirect_to root_path
  end

  private

  def exam_params
    params.require(:exam).permit(:title, 
      :questions_attributes => [:id, :description, :question_type,
        {:options => []}, :_destroy
      ]
    )
  end
end