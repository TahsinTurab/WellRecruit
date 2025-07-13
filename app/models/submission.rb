class Submission < ApplicationRecord
  belongs_to :participation
  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :responses, allow_destroy: true
end
