class AddExtraDataToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :extra_data, :string, null: true
  end
end
