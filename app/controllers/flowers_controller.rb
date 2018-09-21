class FlowersController < ApplicationController
  def index
    @flowers = if params[:search]
      Flower.search(
        query:{
          match:{
            name: params[:search]
          }
        }
      ).records
    else
      Flower.all
    end
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
