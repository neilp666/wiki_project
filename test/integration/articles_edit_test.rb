require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Neil", email: "neil@example.com",
                        password: "password", password_confirmation: "password")
    @article = Article.create(title: "Ruby on Rails", description: "This is a guide to ruby on rails", user: @user)
  end

  test "invalid article update" do
    sign_in_as(@user, "password")
    get edit_article_path(@article)
    assert_template "articles/edit"
    patch article_path(@article), params: { article: { title: " " , description: "some description"} }
    assert_template 'articles/edit'
    assert_select 'h2'
  end

  test "successfully edit a article" do
    sign_in_as(@user, 'password')
    get edit_article_path(@article)
    assert_template 'articles/edit'
    updated_title = "updated title name"
    updated_description = "updated article description"
    patch article_path(@article), params: { article: { title: updated_title, description: updated_description}}
    assert_redirected_to @article
    assert_not flash.empty?
    @article.reload
    assert_match updated_title, @article.title
    assert_match updated_description, @article.description
  end
end
