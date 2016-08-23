class AddFormulaToChemical < ActiveRecord::Migration
  def change
  	add_column :chemicals, :formula, :string
  end
end
