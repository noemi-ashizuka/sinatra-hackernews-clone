class User < ActiveRecord::Base
  has_many :posts
  
  before_validation :clean_input
  # after_save :welcome_user

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  # validates :email, format: { with: /\A.*@.*\.com\z/ }

  private

  def clean_input
    self.email = email.strip unless email.nil?
  end

  # def welcome_user
  #   FakeMailer.instance.mail('mochi@gmail.com', 'Welcome to fake hacker news!')
  # end
end
