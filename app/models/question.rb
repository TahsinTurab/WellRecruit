class Question < ApplicationRecord
  belongs_to :assessment
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :statement, presence: true
  validates_associated :answers
end
