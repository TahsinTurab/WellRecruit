class RecruiterMailer < ApplicationMailer

  def approval_email(recruiter)
    @recruiter = recruiter
    @url  = 'http://0.0.0.0:3000/users/sign_in' # URL to your app's login page or dashboard
    mail(to: @recruiter.email, subject: 'Your Account Has Been Approved!')
  end
end
