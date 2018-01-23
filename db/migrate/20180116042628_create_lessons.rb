class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.datetime :lesson_time
      t.integer :duration
      t.references :location, foreign_key: true
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :horse, foreign_key: true

      t.timestamps
    end
  end
end
