class ChemCat < ActiveRecord::Base
	has_many :chem_cat_ships
	has_many :chem_subcats
	has_many :chemicals, through: :chem_cat_ships
	has_many :literacies, as: :literable
end
