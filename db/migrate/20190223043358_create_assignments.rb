class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer  :exam_id
      t.integer  :student_id
      t.text     :answers
      t.integer  :user_id
      t.boolean  :is_completed, default: false
      t.timestamps
    end
  end
end
