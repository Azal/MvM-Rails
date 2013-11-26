class MoviesController < ApplicationController

  require 'httparty'
  require 'Movie'

  before_filter :count_imdb
  before_filter :count_rotten
  before_filter :count_both

    def bacon

      @actor1= params[:actor_1]
      @actor2= params[:actor_2]

      @response = HTTParty.post("http://arqui3.ing.puc.cl:27017/api/0.1/actors/bacon",
                                :body=>{'actor[initial_name]'=>@actor1, 'actor[end_name]'=> @actor2})
      respond_to do |format|
        format.js {render 'j_bacon'}
      end
    end

    def movies
      movie_page = params[:movie_page].to_i
      unless params[:movie_page]
        movie_page = 1
      end
      query = Array.new((movie_page-1)*9)
      query = query.concat Movie.all_in().skip((movie_page - 1)*9).limit(10).to_a
      @movies = Kaminari.paginate_array(query).page(params[:movie_page]).per(9)

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
    @movie = Movie.find(params[:id])
  end

  def count_imdb
    @count_imdb = 2545 #Movie.where(:From => 'IMDB').count()
  end
  def count_rotten
    @count_rotten = 3345 #Movie.where(:From => 'Rotten').count()
  end
  def count_both
    @count_both = 4890 #Movie.where(:From => 'Both').count()
  end
end
