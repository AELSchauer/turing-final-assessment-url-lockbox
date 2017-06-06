class Api::V1::LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def update
    if current_user
      @link = current_user.links.find(params[:id])
      if @link.update(link_params) && @link.send_to_hot_read
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
    params.require(:link).permit(:title, :url, :read)
  end
end
