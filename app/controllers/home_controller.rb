class HomeController < ApplicationController
  def index
    if params[:genre_id].present?
      if params[:genre_id] == 0.to_s
        books = Book.all.order('RANDOM()')
        @page_title = "All Books"
      else
        genre_id = params[:genre_id]
        books = Book.joins(:genres).where(genres: {id: genre_id })
        @page_title = "Books in #{Genre.find(genre_id).name}"
      end
    else
      books = Book.all
      @page_title = "All Books"
    end

    @books = books.page(params[:page]).per(20)
    @genres = Genre.all.order(name: :asc)
  end
end
