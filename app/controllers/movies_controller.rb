class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_movie_and_check_permission, only: [:edit, :update, :destroy]


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
      current_user.join!(@movie)
    redirect_to movies_path
    else
    render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page => 3)
  end

  def update
    if @movie.update(movie_params)
    redirect_to movies_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @movie.destroy
    flash[:alert] = "电影已删除"
    redirect_to movies_path
  end

  def join
    @movie = Movie.find(params[:id])
    if !current_user.is_member_of?(@movie)
      current_user.join!(@movie)
      flash[:notice] = "收藏本电影成功！"
    else
      flash[:warning] = "早已收藏本电影^^"
    end
    redirect_to movie_path(@movie)
  end

  def quit
    @movie = Movie.find(params[:id])
    if current_user.is_member_of?(@movie)
      current_user.quit!(@movie)
      flash[:notice] = "取消收藏成功！"
    else
      flash[:warning] = "并没有收藏，如何取消><"
    end
    redirect_to movie_path(@movie)
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
