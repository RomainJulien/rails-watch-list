class BookmarksController < ApplicationController
  def destroy
    @bookmark = Bookmark.find(params[:list_id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Le film a été supprimé de la liste.'
  end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @selected_movie = Movie.find(params[:movie_id]) if params[:movie_id].present?
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    puts "Params reçus : #{params[:bookmark]}"  # Ajout du log

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Le film a bien été ajouté à la liste.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
