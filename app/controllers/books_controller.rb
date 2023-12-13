class BooksController < ApplicationController
  def index
    @books = Book.all
    @genres = Genre.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    @results = perform_search_books(params[:search])
  end

  private

  def perform_search_books(query)
    Book.where("title LIKE ?", "%#{query}%")
  end
end
