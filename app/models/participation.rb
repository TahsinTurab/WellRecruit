class Participation < ApplicationRecord
  belongs_to :application
  belongs_to :assessment
  has_many :submissions, dependent: :destroy
  accepts_nested_attributes_for :submissions, allow_destroy: true
end
