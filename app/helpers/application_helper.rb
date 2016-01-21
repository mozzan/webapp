module ApplicationHelper
  include ActionView::Helpers::TagHelper

  def embed(id)
    content_tag(:iframe, nil, src: "http://www.youtube.com/embed/#{id}")
  end
end