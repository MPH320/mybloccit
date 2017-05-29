class Comment < ActiveRecord::Base
  belongs_to :post, :sponsored_post
end
