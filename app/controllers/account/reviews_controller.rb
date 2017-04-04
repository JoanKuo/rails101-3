class Account::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = current_user.reviews
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(review_params)
  end

  def destroy
    @review = Review.find(params[:movie_id])
    @review.destroy
    flash[:alert] = "评论已删除"
    redirect_to account_path(reviews)
  end

    private

    def review_params
      params.require(:review).permit(:content)
    end


end
