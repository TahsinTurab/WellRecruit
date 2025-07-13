class ApplicantsMailer < ApplicationMailer

  def invitation(application)
    send_mail(application, "Congratulations! You are selected for the MCQ assessment")
  end

  def rejection(application)
    send_mail(application, "Sorry! We can not proceed together at this time")
  end

  private

  def send_mail(application, subject)
    @user = application.user
    @application = application
    @url = application_url(id: application.id, host: '0.0.0.0', port: 3000)
    mail(to: @user.email, subject: subject)
  end
end
