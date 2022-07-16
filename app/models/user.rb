# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field = :email
    c.crypto_provider = ::Authlogic::CryptoProviders::BCrypt
  end

  validates :first_name, :last_name, :email, presence: true

  validates :email,
    format: {
      with: /@/,
      message: 'should look like an email address.'
    },
    length: { maximum: 100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_email?
    }

  validates :password,
    confirmation: { if: :require_password? },
    length: {
      minimum: 8,
      if: :require_password?
    }
  validates :password_confirmation,
    length: {
      minimum: 8,
      if: :require_password?
    }

  attr_writer :password_confirmation
end
