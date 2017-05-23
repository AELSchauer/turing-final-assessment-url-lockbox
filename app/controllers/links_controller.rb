class LinksController < ApplicationController
  def index
    redirect_to login_path if current_user.nil?
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
