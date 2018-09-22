module FlowerTagSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Set up index configuration and mapping
    mapping do
      indexes :id, type: "integer", index: "not_analyzed"
      indexes :tag, type: "string", analyzer: "kuromoji_analyzer",

      _source: {enabled: true},
      _all: {enabled: true, analyzer: "kuromoji_analyzer"} do
        indexes :id, type: "integer", index: "not_analyzed"
        indexes :tag, type: "string", analyzer: "kuromoji_analyzer"
      end
    end

    index_name "flower_#{Rails.env}"

    def as_indexed_json(options={})
      flower_attrs = {
        id: self.id,
        tag: self.tag
      }
      flower_attrs.as_json
    end
  end

  def self.search
    search_definition = Elasticsearch::DSL::Search.search({
      match: {
        "flower_tag.keyword": self,
        fuzziness: "AUTO"
      }
    })
  end


  module ClassMethods
    def create_index!(options={})
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
