class CreateProgrammingTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :programming_topics do |t|
      t.string :topic
    end
  end
end
