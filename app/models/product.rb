class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :price, :description
  belongs_to :category
end
