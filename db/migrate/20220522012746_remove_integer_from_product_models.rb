class RemoveIntegerFromProductModels < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_models, :integer, :string
  end
end
