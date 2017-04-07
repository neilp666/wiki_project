require 'test_helper'

class ArticlesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Neil", email: "neil@example.com")
    @article = Article.create(title: "Ruby", description: "Getting started with Ruby", user: @user)
  end

  test 'Delete a successful article' do
    get article_path(@article)
    assert_template 'articles/show'
    assert_select 'a[href=?]', article_path(@article), text: "Delete Article"
    assert_difference 'Article.count', -1 do
      delete article_path(@article)
    end
    assert_redirected_to articles_path
    assert_not flash.empty?
  end
end
