module FlowerSearchable
  # ActiveSupportクラスを継承
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    index_name "flower_#{Rails.env}"

    # Set up index configuration and mapping
    settings do
      mappings dynamic: 'false' do
        indexes :name, type: 'text', analyzer: "kuromoji"

        indexes :flower_tags, type: :nested do
          indexes :tag, type: 'text', analyzer: "kuromoji"
          indexes :red, type: 'text', analyzer: "kuromoji"
          indexes :blue, type: 'text', analyzer: "kuromoji"
          indexes :green, type: 'text', analyzer: "kuromoji"

        end
      end
    end


    def as_indexed_json(options={})
      flower_attrs = {
        id: self.id,
        name: self.name
      }
      flower_attrs[:flower_tags] = self.flower_tag.map do |fl|
        {
          tag: fl.tag,
          red: fl.red,
          blue: fl.blue,
          green: fl.green
        }
      end
      flower_attrs.as_json
    end

    def self.search query
      search_definition = Elasticsearch::DSL::Search.search({
        match_all: {
          query: query,
          fuzziness: "AUTO",
          fields: ['name', 'flower_tags.tag', 'flower_tags.red', 'flower_tags.green', 'flower_tags.blue']
        }
      })
    end
  end
end