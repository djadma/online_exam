class AssignmentsController < ApplicationController
  load_and_authorize_resource
  before_action :exam_already_done, only: [:start_exam]

  def index
    @assignments = current_user.assignments.not_completed
  end

  def new
    @exams = current_user.exams
    @students = User.students
    @assignment = current_user.tasks.new
  end

  def create
    @assignment = current_user.tasks.new(assignment_params)
    if @assignment.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'new'
    else
      redirect_to :action => 'new'
    end
  end

  def start_exam
    @exam = @assignment.exam
    @questions = @exam.questions
  end

  def update
    @assignment.is_completed = true 
    if @assignment.update(assignment_params)
      flash[:notice] = "Successfully completed the test"
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_to assignments_url
  end

  def show
    @questions = @assignment.exam.questions
  end

  def completed
    @assignments = Assignment.completed.joins(:exam).where("exams.user_id = ?", current_user.id)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:exam_id, :student_id, 
      :is_completed, answers: [])
  end

  def exam_already_done
    @assignment = Assignment.find(params[:id])
    if @assignment.is_completed
      flash[:notice] = "Already done the exam"
      redirect_to assignments_url  
    end
  end
end