class CreateItemChemShips < ActiveRecord::Migration
  def change
    create_table :item_chem_ships do |t|
      t.float :percentage
      t.references :item, index: true
      t.references :chemical, index: true

      t.timestamps
    end
  end
end
