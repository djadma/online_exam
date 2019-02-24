class Question < ApplicationRecord

  serialize :options, Array

  # == Constants ============================================================
  
  # == Relationships ========================================================
  belongs_to :exam

  # == Methods ==============================================================

  def objectives
    options.reject { |e| e.to_s.empty? }
  end
end
