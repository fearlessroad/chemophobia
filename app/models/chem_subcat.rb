class ChemSubcat < ActiveRecord::Base
  belongs_to :chem_cat
  has_many :chem_cat_ships
  has_many :literacies, as: :literable
end
