class Gmo < ActiveRecord::Base
  belongs_to :item
  has_many :literacies, as: :literable
end
