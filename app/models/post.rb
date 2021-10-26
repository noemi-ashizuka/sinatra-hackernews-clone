class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, :url, :user, presence: true
  # validates :title, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 5 }
  # validates :url, format: { with: /https?:\/\/(www\.)?.*\.(\w{3}|\w{2}\.\w{2}).*/ }
end
