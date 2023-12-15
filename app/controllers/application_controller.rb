class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_pages
  before_action :initialize_session

  def search
    category = params[:category]
    search_query = params[:search]

    # Handle search based on the category
    if category == 'all'
      @authors = perform_search_authors(search_query).page(params[:page]).per(20)
      @results =  perform_search_books(search_query).page(params[:page]).per(20)
    elsif category == 'book'
      @results = perform_search_books(search_query).page(params[:page]).per(20)
    elsif category == 'author'
      @authors = perform_search_authors(search_query).page(params[:page]).per(20)
    else
      pp "Error"
    end

    @genres = Genre.all.order(name: :asc)
  end

  protected

  def set_user_pages
    @user_pages = UserPage.all
  end

  def perform_search_books(query)
    Book.where("title LIKE ?", "%#{query}%")
  end

  def perform_search_authors(query)
    Author.where("name LIKE ?", "%#{query}%")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id, :first_name, :last_name, :is_admin, :address, :phone, :postal_code])
  end

  helper_method :set_user_pages
  helper_method :cart
  helper_method :add_to_cart

  def initialize_session
    session[:shopping_cart] ||= {}
  end

  def add_to_cart(book_id, quantity)
    book = Book.find(book_id)
    session[:shopping_cart][book.id.to_s] ||= 0
    session[:shopping_cart][book.id.to_s] += quantity.to_i
  end

  def remove_from_cart(book_id, quantity)
    book = book.find(book_id)
    if session[:shopping_cart][book.id.to_s]
      session[:shopping_cart][book.id.to_s] -= quantity.to_i
      session[:shopping_cart].delete(book.id.to_s) if session[:shopping_cart][book.id.to_s] <= 0
    end
  end

  def clear_cart
    session[:shopping_cart] = {}
  end

  def cart
    cart_items = []
    session[:shopping_cart].each do |book_id, quantity|
      book = book.find(book_id)
      cart_items << { book: book, quantity: quantity }
    end
    cart_items
  end
end
