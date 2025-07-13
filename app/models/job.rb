class Job < ApplicationRecord
  belongs_to :user
  has_one :assessment, dependent: :destroy
  belongs_to :company

  has_many :applications, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { minimum: 6 }
  validates :overview, presence: true
  validates :responsibilities, presence: true
  validates :requirements, presence: true
  validates :benifits, presence: true
  validates :location, presence: true
  validates :deadline, presence: true
  validates :salary_range, presence: true
  validate :deadline_cannot_be_in_the_past

  private

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end
end
