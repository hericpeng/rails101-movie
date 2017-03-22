class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update, :destroy]

    def new
        @movie = Movie.find(params[:movie_id])
        @review = Review.new
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
        if current_user != @review.user
            redirect_to account_reviews_path, alert: 'You have no permission.'
        end
      end

    def update
        @movie = Movie.find(params[:movie_id])
        @review = Review.find(params[:id])
        if @review.update(review_params)
            redirect_to movies_path, notice: 'Review Update Success'
        else
            render :edit
        end
   end

    def destroy
        @movie = Movie.find(params[:movie_id])
        @review = Review.find(params[:id])
        redirect_to movies_path, alert: 'Review Deleted' if @review.destroy
    end

    private

    def review_params
        params.require(:review).permit(:content)
    end
end
