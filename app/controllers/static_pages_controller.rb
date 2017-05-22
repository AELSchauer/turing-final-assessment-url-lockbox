class StaticPagesController < ApplicationController
  def root
    redirect_to login_path if current_user.nil?
  end
end
