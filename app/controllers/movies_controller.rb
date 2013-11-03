class MoviesController < ApplicationController

  def index

    #@Movies = Movie.all()

  end

  def show
    @search = params[:search]
    @movies = Movie.all().to_a.pop(10)
    #@movies = Movie.all(conditions: { :RatingIMDB => /#{search}/ }).to_a

  end

  def detail
    @movie = Movie.find(params[:id]);
  end

end
