class PagesController < ApplicationController
  def top
    redirect_to posts_path if user_signed_in?
  end

  def terms; end

  def privacy; end

  def operator; end
end
