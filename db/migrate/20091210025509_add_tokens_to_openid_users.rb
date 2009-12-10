class AddTokensToOpenidUsers < ActiveRecord::Migration
  def self.up
    add_column :openid_users, :atoken, :string
    add_column :openid_users, :asecret, :string
  end

  def self.down
    remove_column :openid_users, :asecret
    remove_column :openid_users, :atoken
  end
end
