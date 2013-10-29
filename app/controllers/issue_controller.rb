require 'ostruct'
require 'issue_service'

class IssueController < ApplicationController
  def create
    issue = add_issue(params)
    send_mail issue

    render 'buzon/sugerenciacreada'
  end

  def summary
    @summary  = params['summary']
    @fullname = params['fullname']
    @dni      = params['dni']
    @email    = params['email']

    render 'buzon/sugerencia'
  end

  def confirm
    IssueService.new.confirm(params[:uuid])

    render 'buzon/thanksforconfirm'
  end

  def wall
    @issues = IssueService.new.fetch_confirmed

    render 'buzon/muro'
  end

  private

  def send_mail(issue)
    IssueMailer.send_confirmation_link(issue.email, issue.fullname, issue.uuid)
  end

  def add_issue(params)
    request_dto = OpenStruct.new(params)
    issue = IssueService.new.add(request_dto)

    return issue
  end
end
