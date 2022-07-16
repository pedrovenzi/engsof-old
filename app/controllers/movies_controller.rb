# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.all_ratings
    @movies = Movie.all
    if params[:ratings]
      ratings_filter = []
      params[:ratings].each_key {|rating| ratings_filter.append(rating)}
      @movies = Movie.where(rating: ratings_filter)
    end
    if params[:sort_by]
      @movies.order!(params[:sort_by])
      @title_style = 'hilite' if params[:sort_by] == 'title'
      @date_style = 'hilite' if params[:sort_by] == 'release_date'
    end
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date,:sort_by,:ratings)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end