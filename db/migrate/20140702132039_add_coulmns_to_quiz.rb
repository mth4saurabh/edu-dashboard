class AddCoulmnsToQuiz < ActiveRecord::Migration
  def change
  
  add_column :quizzes, :name, :string
  add_column :quizzes, :course_id, :integer

  end
end
