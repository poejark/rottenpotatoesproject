class Movie < ActiveRecord::Base
  
  
  def self.all_ratings
    Movie.uniq.pluck(:rating)
  end
  
  def self.with_ratings(ratings)
    if ratings.nil?
      Movie.all
    else
      Movie.where("lower(rating) IN ?", ratings.map(&:downcase))
    end
#     Movie.where(rating: ratings.map(&:downcase))
  end
end