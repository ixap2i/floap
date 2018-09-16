require 'elasticsearch/model'
class Flower < ApplicationRecord
  include Elasticsearch::Model
  include FlowerSearchable
end
