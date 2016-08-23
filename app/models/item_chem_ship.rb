class ItemChemShip < ActiveRecord::Base
  belongs_to :item
  belongs_to :chemical
end
