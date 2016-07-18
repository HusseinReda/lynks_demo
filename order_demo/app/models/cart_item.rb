class CartItem < ActiveRecord::Base
  belongs_to :order
end
