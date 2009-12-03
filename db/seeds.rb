require 'yaml'

base_path  = File.dirname(__FILE__) + "/seed"
activities = YAML.load(File.read("#{base_path}/activities.yaml"))

activities["activities"].each do |activity|
  Activity.create!(
    :activity_indirect_object          => activity["activity_indirect_object"],
    :activity_indirect_object_bookmark => activity["activity_indirect_object_bookmark"],
    :activity_noun                     => activity["activity_noun"],
    :activity_object                   => activity["activity_object"],
    :activity_object_bookmark          => activity["activity_object_bookmark"],
    :activity_object_title             => activity["activity_object_title"],
    :activity_verb                     => activity["activity_verb"],
    :author_bookmark                   => activity["author_bookmark"],
    :avatar                            => activity["avatar"],
    :nickname                          => activity["nickname"],
    :entry_content                     => activity["entry_content"]
  )
end
