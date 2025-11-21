class BookmarksController < ApplicationController
  # def new
  #   @list = List.find(params[:list_id])
  #   @bookmark = Bookmark.new
  # end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), status: :see_other, notice: "movie added! thanks for the recommendation <3"
    else
      @bookmarks = Bookmark.where(list_id: params[:list_id])
      render 'lists/show', status: :unprocessable_content
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
