class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.current_movie movie_id
    Movie.find(movie_id)
  end
  
  def self.movies_with_director director
    Movie.where('director = :director', :director => director)
  end
  
  def self.by_director movie_id
    movie = self.current_movie(movie_id)
    
    if movie.director.nil? or movie.director.strip.empty?
      return nil, movie.title
    else
      movies = self.movies_with_director(movie.director)
      return movies, movie.title
    end
  end
end
