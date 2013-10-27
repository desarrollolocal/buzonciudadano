class IssueMailer < ActionMailer::Base
  default :from => 'elbuzondelciudadano@gmail.com'

  def new_issue(to, user_name, uuid)
    @user = to
    @url  = 'http://buzon:3000/issue/confirm/'+uuid
    @user_name = user_name
    mail(to: @user, subject: 'Welcome to My Awesome Site').deliver
  end
end
