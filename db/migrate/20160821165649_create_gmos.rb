class CreateGmos < ActiveRecord::Migration
  def change
    create_table :gmos do |t|
      t.string :name
      t.text :description
      t.string :developer
      t.references :item, index: true
      t.string :trait
      t.string :dna_source

      t.timestamps
    end
  end
end
