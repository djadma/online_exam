class User < ApplicationRecord

  # == Constants ============================================================
  TEACHER = "teacher".freeze
  STUDENT = "student".freeze
  ROLES = [TEACHER, STUDENT]
  
  # == Extensions ===========================================================

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # == Relationships ========================================================
  has_many :exams, dependent: :destroy
  has_many :assignments, :foreign_key=>"student_id"
  has_many :tasks, class_name: 'Assignment'
  

  # == Validations ==========================================================
  validates :role, presence: true, :inclusion => { :in => ROLES }
  validates :name, presence: { message: I18n::t('errors.messages.blank') }

  # == Scopes ===============================================================
  scope :students, -> { where(role: User::STUDENT) }
  scope :teacher, -> { where(role: User::TEACHER) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  ["teacher", "student"].each do |method|
    define_method "is_#{method}?" do
      method == role
    end
  end
end
