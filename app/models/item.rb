class Item < ActiveRecord::Base
	has_many :item_chem_ships, dependent: :destroy
	has_many :chemicals, through: :item_chem_ships
	has_many :gmos
	has_many :literacies, as: :literable
	validates :image, :name, :description, presence:true
end
