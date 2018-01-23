class CreateEventSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :event_series do |t|
      t.integer :frequency
      t.string :period
      t.datetime :starttime
      t.datetime :endtime
      t.boolean :all_day
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
