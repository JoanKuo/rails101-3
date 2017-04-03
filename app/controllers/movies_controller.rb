class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if  @movie.save
    redirect_to movies_path
    else
    render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
    redirect_to movies_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert:"权限不足。"
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:alert] = "Movie Deleted"
    redirect_to movies_path
  end

  private

  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert:"权限不足。"
    end
  end

  def movie_params
    params.require(:movie).permit(:name, :description)
  end

end
