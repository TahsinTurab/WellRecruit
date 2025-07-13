class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs, dependent: :destroy
  has_one :company, dependent: :destroy
  belongs_to :office, optional: true, class_name: 'Company'

  has_many :applications, dependent: :destroy

  has_one_attached :avatar

  enum role: [:admin, :recruiter, :candidate]

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :role, presence: true
  before_save :set_is_verified

  private

  def set_is_verified
    self.is_verified = true unless role == "recruiter"
  end
end
