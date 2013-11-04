require 'ostruct'
require 'issue_service'

class IssueController < ApplicationController
  def create
    @issue = add_issue(params)
    send_mail @issue

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

  def show
    @issue = { text: 'the description', summary: 'el titulo', fullname: 'el nombre tel tipo',
      address: 'la direccion donde esta' , images: ['http://placeskull.com/170/170', 'http://placeskull.com/170/170'],
      created_at: Time.new}

    render 'buzon/fichasugerencia'
  end

  private

  def send_mail(issue)
    IssueMailer.send_confirmation_link @issue
  end

  def add_issue(params)
    request_dto = OpenStruct.new(params)
    issue = IssueService.new.add(request_dto)

    return issue
  end
end
