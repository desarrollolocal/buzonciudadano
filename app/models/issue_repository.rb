class IssueRepository

  def initialize(connection=ActiveRecord::Base.connection.raw_connection)
    @connection = connection
  end

  def put(issue)
    images = issue.images && issue.images.join(',')
    @connection.exec(insert_query, [issue.text, issue.summary, issue.fullname,
      issue.address, images, issue.dni, issue.email, issue.uuid, issue.created_at])
  end

  def find_by_uuid(uuid)
   result_set = @connection.exec('select * from issues where uuid=$1', [uuid])

   return NullIssue.new if result_set.ntuples == 0
   Issue.from_map(result_set[0])
  end

  def confirm(issue)
    @connection.exec('UPDATE issues SET confirmed = true WHERE uuid=$1', [issue.uuid])
  end

  def fetch_confirmed
    result_set = @connection.exec('select * from issues where confirmed=true')

    result_set.map do |row|
      Issue.from_map(row)
    end

  end

  private

  def insert_query
    'INSERT INTO issues (text, summary, fullname, address, images, dni, email, uuid, created_at) VALUES
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)'
  end
end
