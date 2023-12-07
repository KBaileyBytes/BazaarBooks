class HomeController < ApplicationController
  def index
    @books = Book.page(params[:page]).per(20)
    @genres = Genre.all.order(name: :asc)
  end
end
