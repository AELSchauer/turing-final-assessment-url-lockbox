class Api::V1::LinksController < ApplicationController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { error: 'Unauthenticated user' }, status: :not_found
    end
  end
end
