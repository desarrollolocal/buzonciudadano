require 'ostruct'
require 'issue_service'

class IssueController < ApplicationController
  def create
    issue = add_issue(params)
    IssueMailer.new_issue(issue.email, issue.fullname, issue.uuid).deliver
    render json: { success: true, issue: get_hash_from(issue) }
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

  def add_issue(params)
    request_dto = OpenStruct.new(params)
    issue = IssueService.new.add(request_dto)

    return issue
  end

  def get_hash_from(issue)
    {text: issue.text, summary: issue.summary, fullname: issue.fullname,
     address: issue.address, images: issue.images, dni: issue.dni, email: issue.email}
  end
end
