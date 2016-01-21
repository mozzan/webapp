class PostsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  include ApplicationHelper

  def index
    if params[:p].nil?
      if params[:year].nil?
        @posts = Wp_post.all
      else
        @posts = find_post
      end

      @posts.each do |post|
        post.post_content = strip_tags(post.post_content)
      end
      render 'index'
    else
      show(params[:p])
    end
  end

  def show(postId)
    @post = Wp_post.find(postId)
    replaceYoutube @post.post_content
    render 'show'
  end

private
  def find_post
    if params[:month].nil?
      @posts = Wp_post.where(post_date: DateTime.new(params[:year].to_i)..DateTime.new(params[:year].to_i + 1))
    else
      month = DateTime.new(params[:year].to_i, params[:month].to_i)
      @posts = Wp_post.where(post_date: month.at_beginning_of_month..month.at_end_of_month)
    end
  end

  def replaceYoutube content
    content.gsub!(/\r\n/, '<br>')
    ids = content.scan(/(https*:\/\/www\.youtube\.com\/watch\?v=([a-zA-Z0-9]+))/i)
    ids.each do |url, id|
      content.sub!("#{url}", wrapYoutube(embed(id)))
    end
  end

  def wrapYoutube content
    "<div class=\"embed-container\">#{content}</div>"
  end
end