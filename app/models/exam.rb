class Exam < ApplicationRecord
  # == Relationships ========================================================
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :assignments
  accepts_nested_attributes_for :questions  , allow_destroy: true
end
