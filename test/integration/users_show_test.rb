require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Neil", email: "neil@example.com",
                      password: "password", password_confirmation: "password")
    @article = Article.create(title: "Ruby on Rails", description: "Get started with Ruby on Rails", user: @user)
    @article2 = Article.create(title: "Javascript", description: "Get started with Javascript", user: @user)
  end

  test 'should get users show' do
    get user_path(@user)
    assert_template 'users/show'
  end
end
