class ChangeEventsColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :location, :string
    remove_column :events, :image_url, :string
  end
end
