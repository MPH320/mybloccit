class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :sponsored_post
  default_scope { order('created_at DESC') }
end
