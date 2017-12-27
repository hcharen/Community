class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :type
      t.integer :size
      t.string :description


      t.timestamps
    end
  end
end
