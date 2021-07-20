class MoviesController < ApplicationController
  
  before_action :get_cookie_state
  after_action :store_cookie_state
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
    
#     if session[:sorted_list] != "1"
#       @ratings_to_show = params[:ratings]
#     end
#     if @rating_replaced != "1"
# #       if ratings were not replaced
#       @ratings_to_show = params[:ratings]
      
#       if @ratings_to_show.nil?
#       @sort_exists = "2"
#       @ratings_to_show = Hash[@all_ratings.collect {|x| [x, "1"]}]
# #       @ratings_to_show = [['G', 1], ['PG', 1], ['PG-13', 1], ['R', 1]].to_h
#       else
#         @sort_exists = "1"
#       end
      
#     end
    if !params[:home].nil?
#       if from the homepage, defer to new inputs
    @ratings_to_show = params[:ratings]
    end
#     Otherwise, keep the cookie loaded ratings
#     
    if @ratings_to_show.nil?
      @sort_exists = "2"
      @ratings_to_show = Hash[@all_ratings.collect {|x| [x, "1"]}]
#       @ratings_to_show = [['G', 1], ['PG', 1], ['PG-13', 1], ['R', 1]].to_h
      else
        @sort_exists = "1"
      end
#     
#     
#     If it's not sorting a current list, then assumes a current list DNE, and assigns it via the refresh
#     Otherwise, @ratings_to_show already exists as a hash
    
      
    
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
  
  def get_cookie_state
    
    if !YAML.load(session[:stored]).nil?
      @ratings_to_show = YAML.load(session[:rating_hash])
    end
  end
  
  def store_cookie_state
    
    if !params[:home].blank?
      session[:stored] = params[:home].to_yaml
#       if its coming from homepage
#       list already sorted
      session[:rating_hash] = @ratings_to_show.to_yaml
      
#       if @sort_exists == "1"
#         session[:sort_exists] = "1".to_yaml
        
#       end
    end
  end
  
end
