class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :sponsored_post
end
