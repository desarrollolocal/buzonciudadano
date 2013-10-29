require 'securerandom'

class Issue
  attr_accessor :text, :summary, :fullname, :address, :images, :email,
    :dni, :uuid, :created_at, :confirmed

  def initialize(text, summary, fullname, address, email, dni)
    @text = text
    @summary = summary
    @fullname = fullname
    @address = address
    @images = []
    @email = email
    @dni = dni
    @uuid = SecureRandom.uuid
    @confirmed = false
    @created_at = Time.new
  end

  def add_images(images)
    @images = images unless images.nil?
  end

  def has_images?
    @images.size != 0
  end

  def confirmed?; @confirmed end

  def self.from_map(a_map)
    issue = Issue.new(a_map['text'], a_map['summary'], a_map['fullname'],
      a_map['address'], a_map['email'], a_map['dni'])
    issue.uuid = a_map['uuid']
    issue.confirmed = a_map['confirmed']
    issue.created_at = a_map['created_at']
    issue.add_images(a_map['images'])

    return issue
  end
end

class NullIssue < Issue
  def initialize; end
  def uuid; '' end
end
