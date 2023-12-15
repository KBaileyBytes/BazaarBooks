class ShoppingCartController < ApplicationController
  def add
    product_id = params[:product_id]
    quantity = params[:quantity]
    add_to_cart(product_id, quantity)
    redirect_back fallback_location: root_path, notice: 'Product added to cart successfully.'
  end

  def remove
    product_id = params[:product_id]
    quantity = params[:quantity]
    remove_from_cart(product_id, quantity)
    redirect_back fallback_location: root_path, notice: 'Product removed from cart successfully.'
  end

  def clear
    clear_cart
    redirect_to root_path, notice: 'Shopping cart cleared successfully.'
  end
end
