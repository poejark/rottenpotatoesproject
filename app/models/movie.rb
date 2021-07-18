class Movie < ActiveRecord::Base
  
  
  def self.all_ratings
    return ['G', 'PG', 'PG-13', 'R']
    
#     Movie.uniq.pluck(:rating)
  end
  
  def self.with_ratings(ratings_list, sort)
    if sort.nil?
      if ratings_list.nil?
        return Movie.all
      else
        return Movie.where(rating: ratings_list.keys)
      end
    elsif sort == "1"
      if ratings_list.nil?
        return Movie.all.order(:title)
      else
        return Movie.where(rating: ratings_list.keys).order(:title)
      end
    
    elsif sort == "2"
#       values is 2, signalling sort by movie titles
      if ratings_list.nil?
        return Movie.all.order(:release_date)
      else
        return Movie.where(rating: ratings_list.keys).order(:release_date)
      end
    end
    
    
  end
end