class Api::V1::LinksController < ApplicationController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { error: 'Unauthorized request' }, status: :unauthorized
    end
  end

  def create
    if current_user
      @link = current_user.links.new(link_params)
      if @link.save
        render json: @link
      else
        render json: { error: @link.errors.full_messages }, status: :bad_request
      end
    else
      render json: { error: 'Unauthorized request' }, status: :unauthorized
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end