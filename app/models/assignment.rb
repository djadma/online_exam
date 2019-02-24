class Assignment < ApplicationRecord
  serialize :answers, Array

  # == Validations ========================================================
  validates :exam_id, :student_id, presence: true
  # == Relationships ========================================================
  belongs_to :exam
  belongs_to :user, :foreign_key=>"student_id"

  # == Scopes ===============================================================
  scope :not_completed, -> { where(is_completed: false) }
  scope :completed, -> { where(is_completed: true) }
end
