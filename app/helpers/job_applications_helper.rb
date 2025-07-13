module JobApplicationsHelper
  def participation_score(application)
    application.participation&.score
  end

  def assessment(application)
    application.selected? && application&.job&.assessment
  end

  def schedule(application)
    assessment = assessment(application)
    assessment&.starting_time.strftime("%A, %B %d, %Y %I:%M %p %Z")
  end

  def duration(application)
    assessment = assessment(application)
    (assessment.ending_time - assessment.starting_time) / 60
  end
end
