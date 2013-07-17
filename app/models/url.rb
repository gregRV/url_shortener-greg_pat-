class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates_presence_of :full_url, :message => "Must enter in a url"
  validates_format_of :full_url, :with => /^http:\/\//, :message => "Must include http:// in url"
end
