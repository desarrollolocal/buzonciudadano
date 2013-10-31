require 'test_helper'
require 'mocha'

class IssueControllerTest < ActionController::TestCase


  test "should send an email when post a new issue" do
    IssueMailer.any_instance.expects(:new_issue)
    post :create, {text: 'a text', summary: 'a summary', images: ['image1']}
  end
end
