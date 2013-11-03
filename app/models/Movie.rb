class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in 'Movies'
  scope :top_ranking, all()

end