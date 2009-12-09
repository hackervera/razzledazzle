class AddOpenidUrlToOpenidUsers < ActiveRecord::Migration
  def self.up
    add_column :openid_users, :openid_url, :string
  end

  def self.down
    remove_column :openid_users, :openid_url
  end
end
