class CreateChemicals < ActiveRecord::Migration
  def change
    create_table :chemicals do |t|
      t.string :name
      t.string :iupac
      t.string :image
      t.text :description
      t.string :ld50
      t.string :origin

      t.timestamps
    end
  end
end
