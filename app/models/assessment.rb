class Assessment < ApplicationRecord
  belongs_to :job
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  has_many :participations, dependent: :destroy

  validates :title, presence: true
  validates :starting_time, presence: true
  validates :ending_time, presence: true
  validate :ending_time_after_starting_time

  private

  def ending_time_after_starting_time
    if starting_time.present? && ending_time.present? && ending_time <= starting_time
      errors.add(:ending_time, "must be after the starting time")
    end
  end
end
