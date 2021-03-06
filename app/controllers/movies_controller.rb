class MoviesController < ApplicationController

  require 'httparty'
  require 'Movie'
  #Page caching vs action caching
  caches_page :movies
  #caches_action :movies, cache_path: proc { |c| c.params.except(:_).merge(format: request.format)}

    def stats
      @count_both = Movie.where(:From => 'Both').count()
      @count_rotten = Movie.where(:From => 'Rotten').count()
      @count_imdb = Movie.where(:From => 'IMDB').count()
      @total = @count_imdb + @count_rotten + @count_both

      respond_to do |format|
        format.js {render 'j_stats'}
      end

    end

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

  def manual_expire
      expire_page :action => :movies
  end
end
