class PostController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def index
    if params[:p].nil?
      @posts = Wp_post.all
      @posts.each do |post|
        post.post_content = strip_tags(post.post_content)
      end
      render 'index'
    else
      view(params[:p])
    end
  end

  def view(postId)
    @post = Wp_post.find(postId)
    render 'view'
  end
end