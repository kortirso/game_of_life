# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::SecurePassword

  has_secure_password
  has_secure_token :confirmation_token, length: 24
  has_secure_token :restore_token, length: 24

  has_one :users_session, class_name: 'Users::Session', dependent: :destroy

  has_many :games_users, class_name: '::Games::User', dependent: :destroy
  has_many :games, through: :games_users

  scope :not_confirmed, -> { where(confirmed_at: nil) }

  def confirmed?
    confirmed_at.present?
  end
end
