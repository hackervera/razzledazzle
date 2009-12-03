class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :activity_indirect_object
      t.string :activity_indirect_object_bookmark
      t.string :activity_noun
      t.string :activity_object
      t.string :activity_object_bookmark
      t.string :activity_object_title
      t.string :activity_verb
      t.string :author_bookmark
      t.string :avatar
      t.string :entry_content
      t.string :nickname

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
