class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    # Capture sorting parameters in session if provided
    session[:sort] = params[:sort] if params[:sort]
    session[:direction] = params[:direction] if params[:direction]

    # Default to title/asc if session doesn't have sorting values
    sort_column = session[:sort]
    sort_direction = session[:direction]

    # Fetch and sort movies based on session values
    @movies = Movie.order("#{sort_column} #{sort_direction}")
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
        # Redirect with the stored sort and direction from the session
        format.html { redirect_to movies_path(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully created." }
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
        # Redirect with the stored sort and direction from the session
        format.html { redirect_to movies_path(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully updated." }
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



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    # Define sortable columns
    def sort_column
      Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
