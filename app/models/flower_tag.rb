require 'elasticsearch/model'
class FlowerTag < ApplicationRecord
  require 'elasticsearch/model'
  include FlowerTagSearchable

  belongs_to :flower

  private
  def flower_tag_params
    params.require(:flower_tag).permit(:flower_id, :tag)
  end
end
