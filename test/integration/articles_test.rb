require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Neil", email: "neil@example.com",
                      password: "password", password_confirmation: "password")
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
    sign_in_as(@user, 'password')
    get article_path(@article)
    assert_template 'articles/show'
    assert_match @article.title, response.body
    assert_match @article.description, response.body
    assert_match @user.name, response.body
    assert_select 'a[href=?]', edit_article_path(@article), text: "Edit Article"
    assert_select 'a[href=?]', article_path(@article), text: "Delete Article"
    assert_select 'a[href=?]', articles_path, text: "Return to articles listing"
  end

  test "create new valid article submission" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    title_of_article = "Installing Rails"
    description_of_article = "Go to the rails guide website "
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: title_of_article, description: description_of_article } }
    end

    follow_redirect!
    assert_match title_of_article.capitalize, response.body
    assert_match description_of_article, response.body
  end

  test "reject invalid article submissions" do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: {name: " ", description: " "} }
    end
    assert_template 'articles/new'
    assert_select 'h2'
  end
end
