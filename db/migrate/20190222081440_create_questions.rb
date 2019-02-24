class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|

      t.integer :exam_id
      t.string  :description
      t.string  :question_type
      t.string  :options

      t.timestamps
    end
  end
end
