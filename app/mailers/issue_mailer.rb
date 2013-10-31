class IssueMailer < ActionMailer::Base
  default :from => 'elbuzondelciudadano@gmail.com'

  def send_confirmation_link(issue)
  	@issue = issue
    mail(to: @issue.email, subject: 'Welcome to My Awesome Site').deliver
  end
end
