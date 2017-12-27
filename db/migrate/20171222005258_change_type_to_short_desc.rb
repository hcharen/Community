class ChangeTypeToShortDesc < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :type, :short_desc
  end
end
