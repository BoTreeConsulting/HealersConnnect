class CreateCourseCategories < ActiveRecord::Migration
  def change
    create_table :course_categories do |t|
      t.string :name
      t.string :alias

      t.timestamps
    end
  end
end
