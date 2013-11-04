class MoviesController < ApplicationController

  def index

    #@Movies = Movie.all()

  end

  def search
    search = params[:search]
    type = params[:type]
    genre = params[:genre]
    #regex para case insensitive y like
    @movies = Movie.all(conditions: { type.to_s => /#{search}/i,
                                      :Genres => /#{genre}/i} ).to_a


  end

  def detail
    @movie = Movie.find(params[:id]);
  end

end
