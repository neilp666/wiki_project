class CreateArticlesProgrammingTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :articles_programming_topics do |t|
      t.integer :article_id
      t.integer :programming_topic_id
    end
  end
end
