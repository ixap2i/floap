module FlowerSearchable
  # ActiveSupportクラスを継承
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model


    # INDEX_FIELDS = %w(name id).freeze

    # Set up index configuration and mapping
    settings do
    {
      "analysis": {
        "analyzer": {
          "keyword_analyzer": {
            "type": "custom",
            "char_filter": [
              "normalize",
              "whitespaces"
            ],
            "tokenizer": "keyword",
            "filter": [
              "lowercase",
              "trim",
              "maxlength"
            ]
          },
          "autocomplete_index_analyzer": {
            "type": "custom",
            "char_filter": [
              "normalize",
              "whitespaces"
            ],
            "tokenizer": "keyword",
            "filter": [
              "lowercase",
              "trim",
              "maxlength",
              "engram"
            ]
          },
          "autocomplete_search_analyzer": {
            "type": "custom",
            "char_filter": [
              "normalize",
              "whitespaces"
            ],
            "tokenizer": "keyword",
            "filter": [
              "lowercase",
              "trim",
              "maxlength"
            ]
          },
          "readingform_index_analyzer": {
            "type": "custom",
            "char_filter": [
              "normalize",
              "whitespaces"
            ],
            "tokenizer": "japanese_normal",
            "filter": [
              "lowercase",
              "trim",
              "readingform",
              "asciifolding",
              "maxlength",
              "engram"
            ]
          },
          "readingform_search_analyzer": {
            "type": "custom",
            "char_filter": [
              "normalize",
              "whitespaces",
              "katakana",
              "romaji"
            ],
            "tokenizer": "japanese_normal",
            "filter": [
              "lowercase",
              "trim",
              "maxlength",
              "readingform",
              "asciifolding"
            ]
          }
        },
        "filter": {
          "readingform": {
            "type": "kuromoji_readingform",
            "use_romaji": true
          },
          "engram": {
            "type": "edgeNGram",
            "min_gram": 1,
            "max_gram": 36
          },
          "maxlength": {
            "type": "length",
            "max": 36
          }
        },
        "tokenizer": {
          "japanese_normal": {
            "mode": "normal",
            "type": "kuromoji_tokenizer"
          },
          "engram": {
            "type": "edgeNGram",
            "min_gram": 1,
            "max_gram": 36
          }
        }
      }
    }
    end
    mapping do
      indexes :id, type: "integer", index: "not_analyzed"
      indexes :name, type: "string", analyzer: "kuromoji_analyzer",

      _source: {enabled: true},
      _all: {enabled: true, analyzer: "kuromoji_analyzer"} do
        indexes :id, type: "integer", index: "not_analyzed"
        indexes :name, type: "string", analyzer: "kuromoji_analyzer"
      end
    end

    index_name "flower_#{Rails.env}"

    def as_indexed_json(options={})
      flower_attrs = {
        id: self.id,
        name: self.name
      }
      flower_attrs.as_json
    end
  end

  def self.search
    search_definition = Elasticsearch::DSL::Search.search({
        match: {
          "flower.keyword": self,
          fuzziness: "AUTO"
        }
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
