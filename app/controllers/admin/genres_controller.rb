class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの新規登録が完了しました"
      redirect_to admin_genres_path
    else
      flash.now[:danger] = "ジャンルの登録に失敗しました"
      @genres = Genre.all
      render :index
    end
  end

  def edit
  end
end
