class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user

  has_one :participation, dependent: :destroy

  has_one_attached :resume

  validate :correct_resume_mime_type

  enum status: [:applied, :selected, :rejected, :passed]

  private

  def correct_resume_mime_type
    if !resume.attached?
      errors.add(:resume, 'required')
    elsif resume.content_type != 'application/pdf'
      errors.add(:resume, 'must be a PDF')
    end
  end
end
