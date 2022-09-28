class ItemsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #returns an array of all items belonging to a user
# get all
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items

    else

    items = Item.all

    end
    render json: items, include: :user
  end



  #creates a new item belonging to a user
   # returns the newly created item
    #returns a 201 created status if the item was created


  def create
    if params[:user_id]
      user = User.find(params[:user_id])

    item = Item.create(params.permit(:name, :description, :price))
    user.items << item
    render json: item, status: 201

    else
      Item.create(params.permit(:name, :description, :price))
    end
end

# find_by
 def show
  item = find_item
  render json: item
 end

# def item_params
#   params.permit(:name, :description, :price)

#   end

  def find_item
    Item.find(params[:id])
    end

 private

 #returns a 404 response if the item/user is not found
  def render_not_found_response
   render json: { error: "Item not found" }, status: :not_found
end
end