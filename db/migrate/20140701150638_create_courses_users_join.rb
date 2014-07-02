class CreateCoursesUsersJoin < ActiveRecord::Migration
  def change
    create_table :courses_users, :id => false do |t|
      t.column 'course_id', :integer
      t.column 'user_id', :integer
    end
  end
end
