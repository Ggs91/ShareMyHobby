class AddCategoryRefToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :category, foreign_key: true, index: true
  end
end
