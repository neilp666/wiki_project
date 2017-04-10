require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(name: "neil", email: "neil@example.com",
                  password: "password", password_confirmation: "password")
    @article = @user.articles.build(title: "Ruby on Rails", description: "How to get started")
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test "article without user should be invalid" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    assert_not @article.valid?
  end

  test "description should be present" do
    @article.description = " "
    assert_not @article.valid?
  end

  test "description shouldn't be less than 5 chars" do
    @article.description = "z" * 5
    assert_not @article.valid?
  end

   test "title shouldn't be less than 3 chars" do
    @article.title = "z" * 3
    assert_not @article.valid?
  end

end
