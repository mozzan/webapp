class Wp_post < ActiveRecord::Base
  default_scope { order('post_date DESC') }
  default_scope { where("`post_type` = 'post' and `post_status` = 'publish'") }

end