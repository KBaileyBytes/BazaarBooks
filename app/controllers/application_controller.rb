class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_pages

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
end
