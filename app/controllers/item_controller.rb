class ItemController < ApplicationController

  def index
    @items = Item.all
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)

      respond_to do |format|
        if @item.save
          format.js
        else
          format.json { render json: @item.errors.messages, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
    end

    def delete
    end

    private

    def item_params
      params.require(:item).permit(:short_desc, :size, :description)
    end

end
