class CreateLiteracies < ActiveRecord::Migration
  def change
    create_table :literacies do |t|
      t.string :word
      t.text :definition
      t.references :literable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
