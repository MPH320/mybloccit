class AddSponsoredPostToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :sponsored_post, index: true, foreign_key: true
  end
end
