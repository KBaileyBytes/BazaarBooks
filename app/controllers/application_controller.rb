class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_pages

  def search
    category = params[:category]
    search_query = params[:search]

    # Handle search based on the category
    if category == 'all'
      @results = perform_search_everything(search_query)
    elsif category == 'book'
      @results = perform_search_books(search_query)
    elsif category == 'author'
      @results = perform_search_authors(search_query)
    else
      redirect_to home_path
    end
  end

  protected

  def set_user_pages
    @user_pages = UserPage.all
  end

  def perform_search_everything(query)
    # Perform a search across both books and authors
    # Return combined results matching the query
    @results = Book.search(query) + Author.search(query)
  end

  def perform_search_books(query)
    # Search only in books
    @results = Book.search(query)
  end

  def perform_search_authors(query)
    # Search only in authors
    @results = Author.search(query)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id, :first_name, :last_name, :is_admin, :address, :phone, :postal_code])
  end

  helper_method :set_user_pages
end
