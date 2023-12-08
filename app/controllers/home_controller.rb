class HomeController < ApplicationController
  def index
    if params[:genre_id].present?
      pp params[:genre_id]
      if params[:genre_id] == 0.to_s
        books = Book.all.order('RANDOM()')
      else
        genre_id = params[:genre_id]
        books = Book.joins(:genres).where(genres: {id: genre_id })
      end
    else
      books = Book.all.order('RANDOM()')
    end

    @books = books.page(params[:page]).per(20)
    @genres = Genre.all.order(name: :asc)
  end
end
