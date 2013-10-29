require 'rspec'
require 'ostruct'
require_relative '../../app/models/issue'
require_relative '../../app/models/issue_service'

describe IssueService do
  let(:repository) { double('repository') }
  let(:service) { described_class.new(repository) }

  it 'adds an issue' do
    repository.should_receive(:put).with(an_instance_of(Issue))

    service.add(an_issue)
  end

  it 'confirms an issue' do
    repository.should_receive(:find_by_uuid).with('a unique id').and_return('an issue')
    repository.should_receive(:confirm).with('an issue')

    service.confirm('a unique id')
  end

  it 'finds all the confirmed issues' do
    repository.should_receive(:fetch_confirmed)

    service.fetch_confirmed
  end

  private

  def an_issue
    OpenStruct.new( {text: 'a text', summary: 'a summary', fullname: 'fullname',
     address: 'address', images: [], dni: nil, email: nil})
  end
end
