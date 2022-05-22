class RemoveWidthFromProductModels < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_models, :width, :string
  end
end
