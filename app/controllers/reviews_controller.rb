class ReviewsController < ApplicationController
before_action :authenticate_user! , :only => [:new, :create]

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
    if !current_user.is_member_of?(@movie)
      redirect_to movie_path(movie),alert:"没收藏不行哦><"
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

  private

  def review_params
    params.require(:review).permit(:content)
  end



end
