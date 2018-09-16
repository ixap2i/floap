module FlowerSearchable
  # ActiveSupportクラスを継承
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model


    INDEXES_FIELDS = %w(name id).freeze


    index_name "flower_#{Rails.env}"

    settings do
      mappings dynamic: "false" do
        indexes :name, analyzer: "kuromoji", type: "string"
      end
    end

    def as_indexed_json(option = {})
      self.as_json.select{|k, _| INDEX_FIELDS.include?(k)}
    end
  end


  module ClassMethods
    def create_index!
      client = __elasticsearch__.client
      client.indices.delete index: self.index_name rescue nil
      client.indices.create(index: self.index_name,
                            body: {
                              settings: self.settings.to_hash,
                              mappings: self.mappings.to_hash
                            })
    end
  end
end
