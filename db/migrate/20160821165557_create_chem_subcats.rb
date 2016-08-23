class CreateChemSubcats < ActiveRecord::Migration
  def change
    create_table :chem_subcats do |t|
      t.string :name
      t.references :chem_cat, index: true

      t.timestamps
    end
  end
end
