class Company < ApplicationRecord
  belongs_to :user

  has_many :recruiters, -> { where(role: :recruiter) }, class_name: 'User', foreign_key: 'office_id'

  has_many :jobs, dependent: :destroy

  has_one_attached :logo

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :registration_number, presence: true, uniqueness: true
end
