class AddUrlToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :url, :string
  end
end
