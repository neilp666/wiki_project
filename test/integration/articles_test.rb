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

  test "should get articles show" do
    get article_path(@article)
    assert_template 'articles/show'
    assert_match @article.title, response.body
    assert_match @article.description, response.body
    assert_match @user.name, response.body
  end

  test "create new valid article submission" do
    get new_article_path
    assert_template 'articles/new'
    title_of_article = "Installing Rails"
    description_of_article = "Go to the rails guide website "
    assert_no_difference 'Article.count', 1 do
      post articles_path, params: {article { title: title_of_article, description: description_of_article }}
    end
    follow_redirect!
    assert_match: title_of_article.capitalize, response.body
    assert_match: description_of_article, response.body
  end

  test "reject invalid article submissions" do
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: {name: " ", description: " "} }
    end
    assert_template 'articles/new'
    assert_select 'h2'
  end
end
