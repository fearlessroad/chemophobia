class CreateChemCatShips < ActiveRecord::Migration
  def change
    create_table :chem_cat_ships do |t|
      t.references :chem_cat, index: true
      t.references :chem_subcat, index: true
      t.references :chemical, index: true

      t.timestamps
    end
  end
end
