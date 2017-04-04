class ReviewsController < ApplicationController
before_action :authenticate_user! , :only => [:new, :create， :edit, :update, :destroy]

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
    if !current_user.is_member_of?(movie)
      redirect_to movie_path(@movie), alert:"没收藏不行哦><"
    end
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.movie = @movie
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.movie = @movie
    @review.user = current_user
    if @review.save(review_params)
      redirect_to account_reviews_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.movie = @movie
    @review.destroy
    flash[:alert] = "评论已删除"
    redirect_to account_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end



end
