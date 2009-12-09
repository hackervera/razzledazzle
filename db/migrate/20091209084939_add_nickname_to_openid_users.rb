class AddNicknameToOpenidUsers < ActiveRecord::Migration
  def self.up
    add_column :openid_users, :nickname, :string
  end

  def self.down
    remove_column :openid_users, :nickname
  end
end
