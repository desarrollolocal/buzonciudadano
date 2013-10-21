require 'securerandom'

class Issue
  attr_accessor :text, :summary, :fullname, :address, :images, :email,
    :dni, :uuid, :created_at, :confirmed

  def initialize(text, summary, fullname, address, images, email,
    dni, uuid = SecureRandom.uuid, confirmed = false, created_at = Time.new)
    @text = text
    @summary = summary
    @fullname = fullname
    @address = address
    @images = images
    @email = email
    @dni = dni
    @uuid = uuid
    @confirmed = confirmed
    @created_at = created_at
  end

  def confirmed?; @confirmed end

  def self.from_map(a_map)
    Issue.new(a_map['text'], a_map['summary'], a_map['fullname'],
      a_map['address'], a_map['images'], a_map['email'], a_map['dni'],
      a_map['uuid'], a_map['confirmed'], a_map['created_at'])
  end
end

class NullIssue < Issue
  def initialize; end
  def uuid; '' end
end
