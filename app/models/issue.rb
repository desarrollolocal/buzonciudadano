require 'securerandom'

class Issue
  attr_accessor :text, :summary, :fullname, :address, :images, :email,
    :dni, :uuid, :created_at, :confirmed


  #las imagenes en un setter
  def initialize(text, summary, fullname, address, images, email, dni)
    @text = text
    @summary = summary
    @fullname = fullname
    @address = address
    @images = images
    @email = email
    @dni = dni
    @uuid = SecureRandom.uuid
    @confirmed = false
    @created_at = Time.new
  end

  def has_images?
    !@images.nil? && @images.size != 0
  end

  def confirmed?; @confirmed end

  def self.from_map(a_map)
    issue = Issue.new(a_map['text'], a_map['summary'], a_map['fullname'],
      a_map['address'], a_map['images'], a_map['email'], a_map['dni'])
    issue.uuid = a_map['uuid']
    issue.confirmed = a_map['confirmed']
    issue.created_at = a_map['created_at']

    return issue
  end
end

class NullIssue < Issue
  def initialize; end
  def uuid; '' end
end
