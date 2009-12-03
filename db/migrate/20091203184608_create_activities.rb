class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :activity_indirect_object, :activity_indirect_object_bookmark, :activity_noun,
               :activity_object, :activity_object_bookmark, :activity_object_title, :activity_verb,
               :author_bookmark, :avatar, :nickname
      t.text :entry_content

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
