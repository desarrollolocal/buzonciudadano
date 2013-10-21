require 'ostruct'
require 'issue_service'

class IssueController < ApplicationController
  def create
    issue = make_issue(params)
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
    @issues = [Issue.from_map({'summary'=> 'da text', 'created_at'=> Time.new,
                               'images'=> [], 'address'=> 'the adress'})]

    render 'buzon/muro'
  end

  private

  def make_issue(params)
    issue = IssueService.new.add(OpenStruct.new(params))
    IssueMailer.new_issue(issue.email, issue.fullname, issue.uuid).deliver
    issue
  end

  def get_hash_from(issue)
    {text: issue.text, summary: issue.summary, fullname: issue.fullname,
     address: issue.address, images: issue.images, dni: issue.dni, email: issue.email}
  end
end
