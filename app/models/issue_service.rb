class IssueService

  def initialize(repository=IssueRepository.new)
    @issues = repository
  end

  def add(issue_data)
    issue = Issue.new(issue_data.text, issue_data.summary, issue_data.fullname,
      issue_data.address, issue_data.email, issue_data.dni)
    issue.add_images(issue_data.images)

    @issues.put(issue)
    issue
  end

  def confirm(uuid)
    issue = @issues.find_by_uuid(uuid)
    @issues.confirm(issue)
  end

  def fetch_confirmed
    @issues.fetch_confirmed
  end

end