class Literacy < ActiveRecord::Base
  belongs_to :literable, polymorphic: true
end
