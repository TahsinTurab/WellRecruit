module JobsHelper
  def has_applied(job)
    job.applications.find_by(user_id: current_user.id)
  end

  def can_apply?(job)
    job.deadline > Time.now and current_user.candidate?
  end
end
