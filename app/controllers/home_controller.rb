class HomeController < ApplicationController

  def index
    redirect_to assignments_path if current_user.is_student?
  end

end