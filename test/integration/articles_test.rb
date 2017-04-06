require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Neil", email: "neil@example.com")
    @article = Article.create(title: "Ruby on Rails", description: "Get started with Ruby on Rails", user: @user)
    @article2 = Article.create(title: "Javascript", description: "Get started with Javascript", user: @user)
  end

  test "should get articles index" do
    get articles_path
    assert_response :success
  end

  test "should get articles listing" do
    get articles_path
    assert_template 'articles/index'
    assert_match @article.title, response.body
    assert_match @article2.title, response.body
  end
end
