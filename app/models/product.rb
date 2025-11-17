class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :product_id, type: String 
  field :title, type: String
  field :link, type: String
  field :price, type: String
  field :rating, type: Float
  field :reviews, type: Integer
  field :thumbnail, type: String
  field :source, type: String
end