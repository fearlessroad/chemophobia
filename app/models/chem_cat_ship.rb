class ChemCatShip < ActiveRecord::Base
  belongs_to :chem_cat
  belongs_to :chem_subcat
  belongs_to :chemical
end
