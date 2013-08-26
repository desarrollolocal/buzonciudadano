class IssueService

  def initialize(repository=IssueRepository.new)
    @repository = repository
  end

  def add(issue_request)
    Issue.new(issue_request.text, issue_request.summary,
              issue_request.fullname, issue_request.address,
              issue_request.images, issue_request.email, issue_request.dni).tap { |issue| @repository.put(issue) }
  end
end

