require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "neil", email: "neil@example.com",
                        password: "password", password_confirmation: "password")
  end

  test "user enters incorrect edit details " do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: " ", email: "neil@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test 'user enters valid edit details' do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "neil1", email: "neil1@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match 'neil1', @user.name
    assert_match 'neil1@example.com', @user.email
   end
  end

