class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        #format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.html { redirect_to movie_url(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        #format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.html { redirect_to movie_url(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #For sorting
  class MoviesController < ApplicationController
    def index
      # Set default sort_column and sort_direction if none are provided
      sort_column = params[:sort] || 'title'
      sort_direction = params[:direction] || 'asc'
      
      # Store sort settings in session to persist after navigation
      session[:sort] = sort_column
      session[:direction] = sort_direction
  
      @movies = Movie.order("#{sort_column} #{sort_direction}")
    end
  end

  # app/controllers/movies_controller.rb
  helper_method :sort_column, :sort_direction

  def index
    @movies = Movie.order("#{sort_column} #{sort_direction}")
  end

  private

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
