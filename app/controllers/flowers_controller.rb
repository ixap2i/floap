class FlowersController < ApplicationController
  def index
    if params[:search]
      @flowers_results = Flower.__elasticsearch__.search("*#{params[:search]}*")
      @ids = @flowers_results.map{|f| f.id}
      @flowers = Flower.where(id: @ids)
    else
      @flowers = Flower.all
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
