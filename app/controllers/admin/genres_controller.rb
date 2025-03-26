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
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_genres_path
    else
      flash.now[:danger] ="変更の保存に失敗しました"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
