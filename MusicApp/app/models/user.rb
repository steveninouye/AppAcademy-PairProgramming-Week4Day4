# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_reader :password

  validates_presence_of :email, :password_digest, :session_token

  validates :email, :password_digest, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.validate_login(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  def self.create(email, password)
    User.new(email: email, password_digest: BCrypt::Password.create(password)).reset_session_token!
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def set_token
    self.session_token = SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.set_token
    self.save!
  end

  def validate_other_password(password)
    is_password?(password)
  end

end
