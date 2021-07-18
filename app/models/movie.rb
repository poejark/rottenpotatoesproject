class Movie < ActiveRecord::Base
  
  
  def self.all_ratings
    return ['G', 'PG', 'PG-13', 'R']
    
#     Movie.uniq.pluck(:rating)
  end
  
  def self.with_ratings(ratings_list)
    
    if ratings_list.nil?
      return Movie.all
    else
      return Movie.where(rating: ratings_list.keys)
    end
    
  end
end