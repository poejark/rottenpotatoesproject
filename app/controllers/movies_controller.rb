class MoviesController < ApplicationController
#   @all_ratings = Movie.all_ratings
#   @ratings_to_show = params[:rating].each_key
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#     sort => 1 means movie_title by ASC
  #   sort => 2 means release_date by ASC
     #pass_sorts => 1 means pass the sorted movies to the controller, instead of getting them from params
     
    
    
#     ratings = @ratings_to_show.map(&:downcase)
    @all_ratings = Movie.all_ratings
    
    
    @ratings_to_show = params[:ratings]
    
    
    
#     If it's not sorting a current list, then assumes a current list DNE, and assigns it via the refresh
#     Otherwise, @ratings_to_show already exists as a hash
    
      
    if @ratings_to_show.nil?
       
#       Overwrite ratings with cookie?
#       byebug
      
      @ratings_to_show = Hash[@all_ratings.collect {|x| [x, "1"]}]
      
      if !session[:saved_ratings].nil? and params[:action] == "index"
        @ratings_to_show = session[:saved_ratings]
      end
#       @ratings_to_show = [['G', 1], ['PG', 1], ['PG-13', 1], ['R', 1]].to_h
    else 
      session[:saved_ratings] = @ratings_to_show
    end
    
    
    @mov = 0
    sort = params[:sorts_current_list]
    if !sort.nil? and sort == "1"
      @mov = "hilite p-3 mb-2 bg-warning text-primary"
    end
    @movies = Movie.with_ratings(@ratings_to_show, sort)
    
    
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
  
  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
