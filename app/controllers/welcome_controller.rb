class WelcomeController < ApplicationController
  def index
    @posts = Wp_post.all
  end
end