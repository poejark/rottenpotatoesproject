class MoviesController < ApplicationController
  
#   @all_ratings = Movie.all_ratings
#   @ratings_to_show = params[:rating].each_key
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#     ratings = @ratings_to_show.map(&:downcase)
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings]
#     ratings = params[:ratings].each_key
#     if ratings.length <= 0
#       @ratings_to_show = []
#     else
#       @ratings_to_show = ratings
#     end
    if @ratings_to_show.nil?
      @ratings_to_show = [['G', 1], ['PG', 1], ['PG-13', 1], ['R', 1]].to_h
    end
    @mov = 0
    sort = params[:sort]
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
