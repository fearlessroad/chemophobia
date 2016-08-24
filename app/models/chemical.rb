class Chemical < ActiveRecord::Base
	has_many :item_chem_ships, dependent: :destroy
	has_many :items, through: :item_chem_ships
	has_many :chem_cat_ships
	has_many :chem_cats, through: :chem_cat_ships
	has_many :chem_subcats, through: :chem_cat_ships
	has_many :literacies, as: :literable
	validates :name, :formula, :iupac, :description, :ld50, :origin, :image, presence:true
end
