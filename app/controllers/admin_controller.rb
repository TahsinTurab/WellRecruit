class AdminController < ApplicationController
  before_action :set_recruiter, only: [:approve_recruiter, :destroy_recruiter]

  def index
    @recruiters = User.where(role: :recruiter, office_id: current_user.company.id)
  end

  def approve_recruiter
    if @recruiter.update(is_verified: true)
      flash[:notice] = "Recruiter '#{@recruiter.name}' has been verified."
      RecruiterMailer.approval_email(@recruiter).deliver_now
    else
      flash[:notice] = "There arise some issues!"
    end
    redirect_to admin_index_path
  end

  def destroy_recruiter
    @recruiter.destroy!
    flash[:notice] = "Recruiter has been deleted."
    redirect_to admin_index_path
  end

  private

  def set_recruiter
    @recruiter = User.find_by_id(params[:recruiter_id])
  end

end
