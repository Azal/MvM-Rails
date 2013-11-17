class MoviesController < ApplicationController


  require 'httparty'

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
      movie_page = 1
    if params[:movie_page]
      movie_page = params[:movie_page]
    end
    movies_limit = [movie_page.to_i*9 + 100, 200].max

    @movies = Kaminari.paginate_array(Movie.all(conditions: {:Year => '2013'}, limit: movies_limit).to_a).page(params[:movie_page]).per(9)

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
    @count_imdb = Movie.where(:From => 'IMDB').count()
  end
  def count_rotten
    @count_rotten = Movie.where(:From => 'Rotten').count()
  end
  def count_both
    @count_both = Movie.where(:From => 'Both').count()
  end

  def facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(Facebook::APP_ID.to_s, Facebook::SECRET.to_s).get_user_info_from_cookie(cookies)
  end

  def index
    @access_token = @facebook_cookies["access_token"]
    @graph = Koala::Facebook::GraphAPI.new(@access_token)
  end
end
