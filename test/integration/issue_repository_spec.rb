require 'rspec'
require 'pg'
require_relative '../../app/models/issue_repository'
require_relative '../../app/models/issue'

describe IssueRepository do
  let(:conn){ PG.connect( dbname: 'buzonciudadano_test',
                host: '127.0.0.1', port: 5432, user:'buzonciudadano',
                password: 'buzon' )}
  let(:repo){ described_class.new(conn) }

  after(:each){ conn.exec("DELETE FROM issues") }

  it 'puts' do
    put_any_issue

    result = conn.exec( "SELECT * FROM issues" )
    result.getvalue(0, 1).should eql 'a text'
    result.getvalue(0, 2).should eql 'a summary'
    result.getvalue(0, 3).should eql 'the name'
    result.getvalue(0, 4).should eql 'an address'
    result.getvalue(0, 5).should eql 'image one,image two'
  end

  describe 'finds' do

    it 'by uuid' do
      issue = put_any_issue

      found_issue = repo.find_by_uuid(issue.uuid)

      expect(issue.uuid).to eq(found_issue.uuid)
    end

    it 'returns a null object if the uuid is not in the db' do
      found_issue = repo.find_by_uuid('an uuid')

      expect(found_issue.uuid).to eq('')
    end

    it 'all the confirmed issues' do
      confirmed_issue = put_any_issue
      unconfirmed_issue = put_any_issue
      repo.confirm(confirmed_issue)

      issues = repo.fetch_confirmed

      expect(issues.size).to eql 1
      expect(issues[0].uuid).to eql confirmed_issue.uuid
    end

  end

  it 'check if the issue is confirmed' do
    issue = put_any_issue

    expect(issue.confirmed?).to be_false

    repo.confirm(issue)

    confirmed_issue = repo.find_by_uuid(issue.uuid)
    expect(confirmed_issue.confirmed?).to be_true
  end

  def put_any_issue
    issue = any_issue
    repo.put(issue)

    return issue
  end

  def any_issue
    Issue.new('a text', 'a summary', 'the name',
      'an address', ['image one', 'image two'], nil, nil)
  end

end
