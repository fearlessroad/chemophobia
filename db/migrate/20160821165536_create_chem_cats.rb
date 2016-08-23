class CreateChemCats < ActiveRecord::Migration
  def change
    create_table :chem_cats do |t|
      t.string :name

      t.timestamps
    end
  end
end
