class CreateOpenidUsers < ActiveRecord::Migration
  def self.up
    create_table :openid_users do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :openid_users
  end
end
