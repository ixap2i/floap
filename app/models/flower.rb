require 'elasticsearch/model'
class Flower < ApplicationRecord
  include Elasticsearch::Model
  include FlowerSearchable

  has_many :flower_tag
end
