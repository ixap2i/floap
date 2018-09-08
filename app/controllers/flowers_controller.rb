class FlowersController < ApplicationController
  def index
    @flowers = Flower.all
  end

  def create
    @flower = Flower.new(flower_params)
  end

  def update

  end

  private
  def flower_params
    params.require(:flower).permit(:name, :img)
  end
end
