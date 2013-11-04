class MoviesController < ApplicationController

  before_filter :count_imdb
  before_filter :count_rotten
  before_filter :count_both

    def movies
      movie_page = 1
    if params[:movie_page]
      movie_page = params[:movie_page]
    end
    movies_limit = [movie_page.to_i*9 + 100, 200].max

    @movies = Kaminari.paginate_array(Movie.all(limit: movies_limit).to_a).page(params[:movie_page]).per(9)

  end

  def search
    search = params[:search]
    type = params[:type]
    genre = params[:genre]

    #regex para case insensitive y like
    @movies = Movie.all(conditions: { type.to_s => /#{search}/i,
                                      :Genres => /#{genre}/i},
                        sort: [[ :Title, :asc ]]).to_a
  end

  def detail
    @movie = Movie.find(params[:id]);
  end

  def count_imdb
    @count_imdb = Movie.where(:From => 'IMDB').count()
  end
  def count_rotten
    @count_rotten = Movie.where(:From => 'Rotten').count()
  end
  def count_both
    @count_both = Movie.where(:From => 'Both').count()
  end

end
