class AddStuffToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :all_day, :boolean
    add_column :events, :event_series_id, :integer

  end
end
