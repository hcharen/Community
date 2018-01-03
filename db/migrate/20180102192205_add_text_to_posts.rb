class AddTextToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :text, :string
  end
end
